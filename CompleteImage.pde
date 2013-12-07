//Object to hold all info required to export

class CompleteImage{
 
 boolean simPat;
 boolean canPat;
 PImage myImg;
 HashMap simFloss = new HashMap();//might be a dummy
 HashMap conFloss = new HashMap();
 
 //constructor
 CompleteImage(PImage _myImg, HashMap _conFloss, boolean _canPat, HashMap _simFloss, boolean _simPat){
  
   simFloss = new HashMap();//might be a dummy
   conFloss = new HashMap();
   
   myImg = createImage(imgWidth,imgHeight,ARGB);
   //myImg.copy(_myImg,0,0,imgWidth,imgHeight,0,0,imgWidth,imgHeight);
   myImg = _myImg.get();
 
   if(pattern){
     
     //new method
   
     Iterator i = _conFloss.values().iterator();
   
     while(i.hasNext()){
    
      Floss trans = (Floss) i.next(); 
      conFloss.put(trans.DMCcolor, trans); 
     }
   
     Iterator j = _simFloss.values().iterator();
   
     while(j.hasNext()){
     
       Floss trans = (Floss) j.next();
       simFloss.put(trans.DMCcolor, trans);
     }
     
   }else{
     
     //old method
     
     HashMap temp1 = new HashMap(_conFloss);
     temp1.keySet().removeAll(conFloss.keySet());
     conFloss.putAll(temp1);
     
     HashMap temp2 = new HashMap(_simFloss);
     temp2.keySet().removeAll(simFloss.keySet());
     simFloss.putAll(temp2);
    
     
   }
   
   canPat = _canPat;
   simPat = _simPat;
   
    
 } 
 

    
}
