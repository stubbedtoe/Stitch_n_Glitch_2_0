class Floss{
  
   int stitches; 
   String identifier;
   color DMCcolor;
   PShape symbol;


  
  //Constructor will also take a PShape argument
  Floss (String temp_id, color temp_DMC,  PShape temp_sym){
    
    
    identifier = temp_id;
    DMCcolor = temp_DMC;
    stitches = 1;
    symbol = temp_sym;
    
  }  
  
  void count(){
   
   stitches++; 
  }  
  
  void resetCount(){
  
    stitches = 1;
  }
  
  void resetSymbol(PShape newSymbol){
   
    symbol = newSymbol;
    
  }
  
}
