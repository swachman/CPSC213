#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "uthread.h"
#include "uthread_mutex_cond.h"

#define MAX_ITEMS 10
const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int producer_wait_count;     // # of times producer had to wait
int consumer_wait_count;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

struct Pool {
  uthread_mutex_t mutex;
  uthread_cond_t  notEmpty;
  uthread_cond_t  notFull;
  int             items;
};

struct Pool* createPool() {
  struct Pool* pool = malloc (sizeof (struct Pool));
  pool->mutex    = uthread_mutex_create();
  pool->notEmpty = uthread_cond_create (pool->mutex);
  pool->notFull  = uthread_cond_create (pool->mutex);
  pool->items    = 0;
  return pool;
}

void* producer (void* pv) {
  struct Pool* p = pv;
  
  for (int i=0; i<NUM_ITERATIONS; i++) {
      uthread_mutex_lock (p->mutex);
      while(p->items == MAX_ITEMS){
          producer_wait_count++;
          uthread_cond_wait(p->notFull);
      }
      p->items++;
      uthread_cond_signal (p->notEmpty);
      histogram[p->items] ++;
      assert(p->items >=0 && p->items <= MAX_ITEMS);
      uthread_mutex_unlock(p->mutext);
  }
  return NULL;
}

void* consumer (void* pv) {
  struct Pool* p = pv;
  
  for (int i=0; i<NUM_ITERATIONS; i++) {
      uthread_mutex_lock(p->mutex);
      while (p->items<=0) {
          consumer_wait_count++;
          uthread_cond_wait(p->notEmpty);
      }
      p->items--;
      uthread_cond_signal(p->notFull);
      histogram[p->items] ++;
      assert(p->items >=0 && p->items <= MAX_ITEMS);
      uthread_mutex_unlock(p->mutex);
  }
  return NULL;
}

int main (int argc, char** argv) {
  uthread_t t[4];

  uthread_init (4);
  
    struct Pool* p = createPool();
    
    for (int i=0; i<sizeof(t)/sizeof(uthread_t); i++) {
        t[i] = uthread_create((i&1)? producer : consumer, p);
    }
    for (int i=0; i<sizeof(t)/sizeof(uthread_t); i++) {
        uthread_join(t[i], 0);
    }
  
  printf ("producer_wait_count=%d, consumer_wait_count=%d\n", producer_wait_count, consumer_wait_count);
  printf ("items value histogram:\n");
  int sum=0;
  for (int i = 0; i <= MAX_ITEMS; i++) {
    printf ("  items=%d, %d times\n", i, histogram [i]);
    sum += histogram [i];
  }
  assert (sum == sizeof (t) / sizeof (uthread_t) * NUM_ITERATIONS);
}