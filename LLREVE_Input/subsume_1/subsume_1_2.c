extern int __mark(int);
int foo(int x)
{
  if (x % 7 == 0){
    return 8;
  }
  if (x == 1009){
    return 1;
  }
  return x;
}
