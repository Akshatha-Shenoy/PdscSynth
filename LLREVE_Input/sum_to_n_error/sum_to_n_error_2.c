extern int __mark(int);
int foo(int n)
{ 
  int sum = 0;
  int i = 2;
  if(n>0){
  	while(i<n){
    	__mark(42);
    	sum = sum + i;
    	i++;
  	}
  }
  return sum;
}
    

