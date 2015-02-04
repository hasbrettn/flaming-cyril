#include <stdio.h>

int factorial(int n){
  int total = 1;
  while (n != 0){
    total = total * n;
    n = n - 1;
  }
  return total;
}

// int main(int argc, char *argv[]){
//
//    for(int i = 0; i <= 10; i++){
//        printf("%d\n", factorial(i));
//    }
//
//    return 0;
//}