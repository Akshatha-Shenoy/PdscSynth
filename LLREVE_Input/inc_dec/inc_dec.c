extern int __mark(int);
extern int call2();

int foo(int l) {
  int h2 = call2();
  if (h2 > 0){
    __mark(42);
    l = l + h2;
    l = l - h2;
  }


  return l;
}

