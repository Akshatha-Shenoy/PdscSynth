extern int __mark(int);
int foo(int x)
{
  if (x % 7 == 0){
    return 8;
  }
  if (x == 1009){
    return 1;
  }
  if (x == 383){
    return 5;
  }
  return x;
}
