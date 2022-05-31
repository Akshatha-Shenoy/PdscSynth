extern int __mark(int);
int puzzle(int n)
{
  int ct = 0;
  
  while (n != 0)
  {
    __mark(42);
    if (n % 10 > 0) ct++;
    n = n/10;
  }

  return ct;
}
