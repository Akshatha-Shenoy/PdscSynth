extern int __mark(int);
int foo(int x){
  if(x == 42){
    return 0;
  }
  if(x == 0){
    return 42;
  }
  return 0;
}
