extern int __mark(int); 
int foo (int x) {
int z;
int y;
y = 0;
z = 2*x;

while (z>0) {
  __mark(42);
	z--;
	y = y+x;
}

return y;
}
