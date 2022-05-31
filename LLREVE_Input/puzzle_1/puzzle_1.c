extern int __mark(int);
int puzzle(int n)
{
  int ct = 0;
  
  while (__mark(42) && n > 0)
  {
    if (n % 10 > 0) ct++;
    n = n/10;
  }

  return ct;
}
