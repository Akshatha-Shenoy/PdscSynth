extern int __mark(int);
int foo(int x)
{
  if (x % 7 == 0){
    return 8;
  }
  return x % 7;
}

