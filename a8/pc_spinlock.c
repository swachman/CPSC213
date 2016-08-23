#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "uthread.h"
#include "spinlock.h"
#define MAX_ITEMS 10

int items = 0;
spinlock_t items_lock;

const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int producer_wait_count;     // # of times producer had to wait
int consumer_wait_count;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

void produce() {
    while (1){
        while (items == MAX_ITEMS) {
            spinlock_lock(&items_lock);
            producer_wait_count++;
            spinlock_unlock(&items_lock);
        }
        spinlock_lock(&items_lock);
        if (items< MAX_ITEMS) {
            break;
        }
        else{
            spinlock_unlock(&items_lock);
        }
    }
    items++;
    histogram[items] +=1;
    assert(items<=MAX_ITEMS);
    spinlock_unlock(&items_lock);
}

void consume() {
    while (1) {
        while (items<=0) {
            spinlock_lock(&items_lock);
            consumer_wait_count++;
            spinlock_unlock(&items_lock);
        }
        spinlock_lock(&items_lock);
        if (items>0) {
            break;
        }
        else{
            spinlock_unlock(&items_lock);
        }
    }
    items--;
  histogram [items] += 1;
    assert (items >= 0);
    spinlock_unlock(&items_lock);
}

void* producer(void* arg) {
    for (int i=0; i < NUM_ITERATIONS; i++){
    produce();
    }
    return 0;
}

void* consumer(void* arg) {
    for (int i=0; i< NUM_ITERATIONS; i++){
    consume();
    }
    return 0;
}

int main (int argc, char** argv) {
    uthread_init(4);
    spinlock_create(&items_lock);
    uthread_t producers[NUM_PRODUCERS];
    uthread_t consumers[NUM_CONSUMERS];
    
    //test
    for (int i=0; i<10000; i++){
        spinlock_lock(&items_lock);
        items=0;
        spinlock_unlock(&items_lock);
        producer_wait_count=0;
        consumer_wait_count=0;
        for (int j =0; j<MAX_ITEMS+1; j++) {
            histogram[j]=0;
        }
    }
    //
    
    for (int i =0; i< NUM_PRODUCERS; i++){
        producers[i] = uthread_create(producer,0);
    }
    
    for (int i=0;i<NUM_CONSUMERS; i++) {
        consumers[i] = uthread_create(consumer,0);
    }
    for (int i =0; i<NUM_PRODUCERS; i++) {
        uthread_join(producers[i],0);
    }
    
    for (int i=0; i<NUM_CONSUMERS; i++) {
        uthread_join(consumers[i],0);
    }
  printf("Producer wait: %d\nConsumer wait: %d\n",
         producer_wait_count, consumer_wait_count);
  for(int i=0;i<MAX_ITEMS+1;i++)
    printf("items %d count %d\n", i, histogram[i]);
}