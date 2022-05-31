extern int __mark(int);
int puzzle(int n)
{
  while (__mark(42) && n != n){};
  return n/10;
}
