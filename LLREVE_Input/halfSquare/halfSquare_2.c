extern int __mark(int);
extern int call2();
int foo(int max)
{ 
  int i = 0;
  int pc = 0;
  int y = 0;
  int x = call2();
  if( x <= 0 || max <= x){
    return -1;
  }
  while(i < max){
  __mark(42);
  if(pc == 0 && i < x){
    i++;
    y = y + i;
  }
  else if(pc == 0 && i >= x){
    pc = 1;
  }
  else if(pc == 1 && i < max){
    i++;
    y = y+ i;
  }
  else{
  }
 }
  return y;
}
  

