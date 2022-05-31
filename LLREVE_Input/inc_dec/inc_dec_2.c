extern int __mark(int);
extern int call1();

int foo(int l) {
  int h1 = call1();
  if(h1 > 0){
    __mark(42);
    l = l + h1;
    l = l - h1;
  }
 

  return l;
}

