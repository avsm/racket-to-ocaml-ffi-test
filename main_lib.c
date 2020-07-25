#include <stdio.h>

int double_int(int);

int main(int argc, char **argv)
{
  fprintf(stderr, "%d\n", double_int(5));
  fprintf(stderr, "%d\n", double_int(100));
  fprintf(stderr, "%d\n", double_int(25000));
}
