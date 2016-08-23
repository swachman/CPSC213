//
//  p1.c
//  
//
//  Created by TongErin on 16/7/28.
//
//p1

#include <stdlib.h>
#include <stdio.h>
struct B* s;
// define the struct
struct B{
    struct A* d1;
    struct A* d2;
};

struct A{
    int a;
    int b;
};

int main(int argc, char** argv){
    s = malloc (sizeof(struct B));
    s->d1=malloc(sizeof(struct A));
    s->d2=malloc(sizeof(struct A));
//    s->d1->a =*(argv[0]);
//    s->d1->b =*(argv[1]);
//    s->d2->a =*(argv[2]);
//    s->d2->b =*(argv[3]);
    
    s->d1->a =1;
    s->d1->b =2;
    s->d2->a =3;
    s->d2->b =4;

    
    s->d1->a = s->d2->b;
    s->d2->a = s->d1->b;
    
    printf("%d\n",s->d1->a);
    printf("%d\n",s->d1->b);
    printf("%d\n",s->d2->a);
    printf("%d\n",s->d2->b);

}