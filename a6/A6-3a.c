//
//  A6-3a.c
//  
//
//  Created by TongErin on 16/8/2.
//
//
#include <stdio.h>

int data[10];
int* z = data;

void add(int x, int y){
    x = x + z[y];
    z[y] =x;
}

void foo(){
    int a0,a1;
    a0 = 1;
    a1 = 2;
    add(3,4);
    add(a0,a1);
}

void main(){
    foo();
    for (int i=0; int<10; i++){
        printf("%d\n",data[i]);
    }
}

