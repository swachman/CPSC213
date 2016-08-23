//
//  pc_sem.c
//  
//
//  Created by TongErin on 16/8/12.
//
//

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "uthread.h"
#include "uthread_mutex_cond.h"

#define MAX_ITEMS 10
const int NUM_ITERATIONS = 200;
const int NUM_THREADS  = 4;

int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

struct Pool {
    uthread_sem_t mutex;
    uthread_sem_t notEmpty;
    uthread_sem_t notFull;
    uthread_sem_t end;
    int             items;
};

struct Pool* createPool() {
    struct Pool* pool = malloc (sizeof (struct Pool));
    pool->mutex    = uthread_sem_create (1);
    pool->notEmpty = uthread_sem_create (MAX_ITEMS);
    pool->notFull  = uthread_sem_create (0);
    Pool->end      = uthread_sem_create (0);
    pool->items    = 0;
    return pool;
}

void* producer (void* pv) {
    struct Pool* p = pv;
    
    for (int i=0; i<NUM_ITERATIONS; i++) {
        assert(p->items >=0 && p->items <= MAX_ITEMS);
        uthread_sem_wait (p->notEmpty);
        uthread_cond_wait(p->mutex);
        p->items++;
        assert (p->items >= 0 && p->items <= MAX_ITEMS);
        histogram [p->items] ++;
        uthread_sem_signal (p->mutex);
        uthread_sem_signal (p->notFull);
    }
    uthread_sem_signal(p->end);
    return NULL;
}

void* consumer (void* pv) {
    struct Pool* p = pv;
    
    for (int i=0; i<NUM_ITERATIONS; i++) {
        assert(p->items >=0 && p->items <= MAX_ITEMS);
        uthread_sem_wait (p->notFull);
        uthread_sem_wait (p->mutex);
        p->items--;
        assert(p->items >=0 && p->items <= MAX_ITEMS);
        histogram[p->items] ++;
        uthread_sem_signal(p->mutex);
        uthread_sem_signal(p->notEmpty)
    }
    uthread_sem_signal(p->end);
    return NULL;
}

int main (int argc, char** argv) {
    uthread_init (4);
    struct Pool* p = createPool();
    
    for (int i=0; i<NUM_ITERATIONS; i++) {
        uthread_detach (uthread_create((i & 1)? producer : consumer, p));
    }
    for (int i=0; i<NUM_ITERATIONS; i++) {
        uthread_sem_wait(p->end);
    }
    
    printf ("producer_wait_count=%d, consumer_wait_count=%d\n", producer_wait_count, consumer_wait_count);
    printf ("items value histogram:\n");
    int sum=0;
    for (int i = 0; i <= MAX_ITEMS; i++) {
        printf ("  items=%d, %d times\n", i, histogram [i]);
        sum += histogram [i];
    }
    assert (sum == NUM_THREADS* NUM_ITERATIONS);
}
