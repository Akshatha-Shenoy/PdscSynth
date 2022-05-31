extern int __mark(int);
extern int call2();
int sumpc (int max ){
 int i = 0 , y = 0, v = 0;
 int h = call2();
 int pc;
 if( h <= i){
   pc = 1;
 }
 else{
   pc = 0;
 }
   
  if( max <= h || h <= 0){
   		return -1;
    
 }
 while(i != max){
      __mark(42);
      if (h < max && pc == 0 && v == 0) {
        	i++; 
        	if(h <= i){
          		pc = 1;
        	}
        	else{
              pc =0;
            }
    		y += y ;
	  }
	  else if (v == 0 && pc == 1 && i >= h){
	  		v = 1;
        	if(max <= i){
              pc = 3;
            }
        	else{
              pc = 2;
            }
      }
      else if (v == 1 && pc ==2 && i < max){
        	i++;
        	y += y;
        	if(max == i){
              pc = 3;
            }
        	else{
              pc = 2;
            }
      }
      else{
      }
	}
 return y;
}
