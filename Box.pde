class Box {
  color stroke;
  int size;
  //color inside;
  int state; //0=empty box with stroke, 1=a letter inside it, 2=wrong letter, 3=yellow letter, 4=right letter
  char c;
  int x,y;
  
  Box(color s, int siz, int stat) {
   stroke=s;
   size=siz;
   state=stat;
   c=' ';
  }
  
  void display(int xs, int ys) {
     stroke(stroke);
     fill(0);
     rect(xs,ys,size,size); 
     x=xs;
     y=ys;
  }
  
  void redo() {
   if (state==0) fill(0);
   if (state==2) fill(200);
   if (state==3) fill(181,159,59);
   if (state==4) fill(83,141,78);
   rect(x,y,size,size);  
  }
  
  void update() {
     if (state==0) {
       fill(0);
       rect(x,y,size,size);
     }
     if (state==1) {
       fill(255);
       textSize(40);
       textAlign(RIGHT);
       text(c, x+size-10, y+size-10);
     }
     if (state==2) {
       fill(58,58,60); 
       textSize(40);
       textAlign(RIGHT);
       rect(x,y,size,size);  
       fill(255);
       text(c, x+size-10, y+size-10);
     }
     if (state==3) {
       fill(181,159,59);
       textSize(40);
       textAlign(RIGHT);
       rect(x,y,size,size);  
       fill(255);
       text(c, x+size-10, y+size-10);     
     }
     if (state==4) {
       fill(83,141,78);
       textSize(40);
       textAlign(RIGHT);
       rect(x,y,size,size);  
       fill(255);
       text(c, x+size-10, y+size-10);       
     }
  }
  
}
