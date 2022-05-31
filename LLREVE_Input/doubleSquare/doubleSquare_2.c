extern int __mark(int); 
int foo (int x) {
int z;
int y;
y = 0;
z = x;

while (z>0) {
	__mark(42);
	z--;
	y = y+x;
}

y = 2*y;
return y;
}
