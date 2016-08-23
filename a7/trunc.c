//
//  trunc.c
//  
//
//  Created by TongErin on 16/8/9.
//
//

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <assert.h>
#include <string.h>
#include "list.h"

typedef struct list* list_t;

int isNotNull(element_t in){
    return (in != NULL);
}

int isValidInt(element_t in){
    return ((intptr_t)in  >= 0);
}

// Parse the input string
void parseInt(element_t* out, element_t in){
    char* rawString = (char*) in;
    intptr_t* o = (intptr_t*) out;
    char* str;
    
    *o = strtol(rawString, &str, 10);
    if (*str != '\0')
    *o = -1;
}

// Change the integer strings in the rawStr into NULL
void nullifNumElement(element_t* out, element_t intPtr, element_t rawStr){
    char** o = (char**)out;
    intptr_t ip = (intptr_t) intPtr;
    if (ip <0){
    *o = (char*)rawStr;
    }else{
    *o = (char*)NULL;
    }
}

// Truncate strInput
void truncString(element_t* out, element_t intPtr, element_t strInput){
    char** o = (char**)out;
    intptr_t i = (intptr_t) intPtr;
    char* str = strInput;
    int size = (i < (strlen(str) ? i : strlen(str)));
    *o = malloc(size * sizeof(char) + 1);
    strncpy(*o, str, size);
    (*o)[size] = '\0';
}

//Store the largest between x and y
void maxInt(element_t* out, element_t x, element_t y){
    *out = (intptr_t) x > (intptr_t) y ? x : y);
}

//Print the Integer value
    void print (element_t ev) {
   intptr_t e = (intptr_t) ev;
   printf ("%ld\n", e);
 }

//Print the String value

void printStr (element_t ev) {
    char* e = (char*) ev;
    printf ("%s\n", e? e: "Null");
}

int main(int argc, char** argv){
    
    list_t rawList = list_create();
    for (int i = 1; i < argc; i++){
        list_append(rawList, argv[i]);
    }
    
    list_t intList = list_create();
    list_map1(parseInt, intList, rawList);
    
    list_t nullStrList = list_create();
    list_map2(nullifNumElement, nullStrList, intList, rawList);
    
    list_t filteredIntList = list_create();
    list_filter(isValidInt, filteredIntList, intList);
    
    list_t nullFreeStrList = list_create();
    list_filter(isNotNull, nullFreeStrList, nullStrList);
    
    list_t truncStrList = list_create();
    list_map2(truncString, truncStrList, filteredIntList ,nullFreeStrList);
    
    intptr_t maxLen = -1;
    list_foldl(maxInt, (element_t*) &maxLen, filteredIntList);
    
    list_foreach (printStr, truncStrList);
    printf ("%d\n", maxLen);
    
    list_destroy(rawList);
    list_destroy(intList);
    list_destroy(nullStrList);
    list_destroy(filteredIntList);
    list_destroy(nullFreeStrList);
    list_destroy(truncStrList);
}
