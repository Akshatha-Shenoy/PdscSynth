extern int __mark(int);
int foo(int n)
{ 
  int sum1 = 0;
  int i = 0;
  while(i<n){
    __mark(42);
    sum1 = sum1 + i;
    i++;
  }
  return sum1;
}
    

