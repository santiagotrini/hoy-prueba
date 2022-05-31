#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int r = 1;
  int n = atoi(argv[1]);
  for (int i = 2; i <= n; i++)
    r *= i;
  printf("%d\n", r);
  return 0;
}
