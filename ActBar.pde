class ActBar{
 
 boolean isVisible;


 
 //contructor
 ActBar(boolean isVis){
   
   isVisible = isVis;
   
 }
  
 void move(int theY, int theDir){
 
 
     
     if(theDir==-1){
   
       for(int i=0; i<32; i++){//move down
        stroke(orange_active,255-(i*8));
        line(0,theY+i,100,theY+i);
       }
       
     }else{
       
       for(int i=0; i<32; i++){//move up
        stroke(orange_active,0+(i*8));
        line(0,theY+i,100,theY+i);
       }
       
     }
     noStroke();
 
 } 


void setVisible(boolean vis){
   
   isVisible = vis; 
  
}

}

