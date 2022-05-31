extern int __mark(int);
int foo(int n)
{ 
  int sum2 = 0;
  int j = 0;
  while(j<n){
    __mark(42);
    sum2 = sum2 + j;
    j++;
  }
  return sum2;
}
    

