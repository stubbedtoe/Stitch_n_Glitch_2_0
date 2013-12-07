public void radio(int theInt){
  
  if(theInt>-1){
    imgSel = theInt;
  }
  println("imgSel = "+imgSel);
  println("Number of cols: "+complete[imgSel].conFloss.size());
  
}

public void dither_after(int theInt){
 
 if(theInt > 0){
   d2.setVisible(true);
   color_amt.setVisible(false);
 }else{
   d2.setVisible(false);
   color_amt.setVisible(pattern);
 } 
}

public void dither_before(int theInt){
 
 if(theInt > 0){
   d1.setVisible(true);
   
 }else{
   d1.setVisible(false);
 } 
}

public void checkbox(float theFloat){
 
  
}

public void glitchButton(){
 
 println("glitchThis"); 
 glitchThis.start(); 
  
}


void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  String exportcode = "";
  
  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
    if(theEvent.getGroup().getName().equals("beforeType")){
      b_type = int(theEvent.getGroup().getValue());
      
    }
    if(theEvent.getGroup().getName().equals("afterType")){
      
      a_type = int(theEvent.getGroup().getValue());
    }
    
    
    if(theEvent.getGroup().getName().equals("pattern type")){
      
      if(-1 < imgSel && imgSel < 4){//between 0 and 3
      
        
        patterncode = "";
        
       if(patternBox.getItem(0).getState()){//single b+w
        patterncode += "s";    
       }
       
       if(patternBox.getItem(1).getState()){//multi b+W
         
         patterncode += "m";
       }
       
       if(patternBox.getItem(2).getState()){//single colour
         
         patterncode += "e";
       }
       
       if(patternBox.getItem(3).getState()){//multi colour
           patterncode += "h";
        }
                    
       } 
      
      
      println("code :"+code+patterncode);
      
      
    }
   
    if(theEvent.getGroup().getName().equals("export options")){
      
     if(-1 < imgSel && imgSel < 4){//between 0 and 3
      
        
        code = "";
        
       if(checkbox.getItem(0).getState()){//export CSV
        code += "c";    
       }
       
       if(checkbox.getItem(1).getState()){//pdf image
         
         code += "i";
       }
       
       if(checkbox.getItem(2).getState()){//tiff image
         
         code += "t";
       }
     /*  
       if(checkbox.getItem(3).getState()){//colorlist
           code += "l";
        }
        
        */
                    
       } 
      }
      
      println("code :"+code+patterncode);
    }
    
   
  else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
    if(theEvent.getController().getName().equals("glitch") && !actBar.isVisible){
      println("glitchThis"); 
      actBar.setVisible(true);
      exported = false;
      glitchThis.start(); 
      
    }else if(theEvent.getController().getName().equals("Export")){
      
      
      
      if(complete[imgSel].conFloss.size() > 0 && imgSel<4){
     
       if(code.length()>0 || patterncode.length()>0){
        if(!outputSelected){
          
          selectFolder("select a location to save files:","setOutPath");
        }else{
          doExport(imgSel);
        }  
       }
     
      }else{
       txt.setText("You can only export an image that has gone through the 'glitch' process"); //empty image
      }
      
    }
    
    
  }else if(theEvent.isFrom("txt")){
    println("event from controller textarea") ;
  }

}

public void message(){
 isOpen = !isOpen;
 txt.setVisible(!txt.isVisible()); 
}
