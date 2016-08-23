//
//  poly.c
//  
//
//  Created by TongErin on 16/8/9.
//
//
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*
 * Class A
 */

struct Person_calss {
    void*  super;
    void (* toString ) (void* this, char* n);
};

struct Person {
    struct Person_calss* class;
    char* name;
};

void Person_toString (void* thisVP, char* n) {
    struct Person* this = thisVP;
    snprintf(n, strlen("Name: ") + strlen(this->name) + 1, "Name: %s", this->name);
}

struct Person_calss Person_class_obj = {NULL, Person_toString};

struct Person* new_Person(char* n) {
    struct Person* obj = malloc (sizeof (struct Person));
    obj->class = &Person_class_obj;
    obj->name = strdup(n);
    return obj;
}


/*
 * Class Student extends Person
 */

struct Student_class {
    struct Person_class* super;
    void  (* toString ) (void* this, char* n);
    };

struct Student {
    struct Student_class* class;
    char* name;
    int sid;
};

int stu_id_size (int id){
    int count = 0;
    if(d== 0){
        return 1;
    }
    for (; d>0; count++) {
        d/=10;
    }
    return count;

}

void Student_toString (void* thisVP, char* n) {
    struct Student* this =thisVP;
    char superToString[strlen("Name: ") + strlen(this->name) + 1];
    this->class->super->toString(this, superToString);
    int size = strlen(superToString) + strlen( ", SID: ") + stu_id_size(this->sid) + 1;
    snprintf(n, size, "%s, SID: %i", superToString, this->sid);
}

struct Student_class Student_class_obj = {&Person_class_obj, Student_toString};

struct Student* new_Student(char* n, int id) {
    struct Student* obj = malloc (sizeof (struct Student));
    obj->class = &Student_class_obj;
    obj->name = strdup(n);
    obj->sid = id;
    return obj;
}


/*
 * Main
 */

int main(int argc, char** argv) {
    char string[500];
    void* people[2] = {new_Person("Alex"), (struct Person*) new_Student("Alice", 300)};
    for (int i = 0; i < 2; i++){
        People[i] ->class->toString(people[i], string);
        printf("%s\n, string");
    }
}