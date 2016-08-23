//
//  A7_4.c
//  
//
//  Created by TongErin on 16/8/9.
//
//

int foo(int x, int y, int z){
    int t;
    switch (x) {
        case 10:
            t = y + z;
            break;
        case 12:
            t = y - z;
            break;
        case 14:
        if(y>z){
            t = 1;
        }
        else{
            t = 0;
        }
        break;
        
        case 16:
        if(y<z){
            t = 1;
        }
        else{
            t = 0;
        }
            break;
        case 18:
        if(y==z){
            t = 1;
        }
        else{
            t = 0;
        }
        break;
        default:
        t = 0;
    }
    return t;
}