extern int __mark(int);
extern int call1();
int foo(int max)
{ 
  int i = 0;
  int pc = 0;
  int y = 0;
  int x = call1();
  if( x <= 0 || max <= x){
    return -1;
  }
  while(i < max){
  __mark(42);
  if(pc == 0 && i < x){
    y = y + i;
    i++;
  }
  else if(pc == 0 && i >= x){
    pc = 1;
  }
  else if(pc == 1 && i < max){
    y = y+ i;
    i++;
  }
  else{
  }
 }
  return y;
}
  

