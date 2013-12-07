public class ThreadColorList implements Runnable {
 
  Thread thread;
  
  //PGraphicsPDF pdfPattern;
  
  public ThreadColorList(PApplet parent) {

    parent.registerDispose(this);
  }
  
  public void start() {

    thread = new Thread(this);
    actBar.isVisible = true;
    thread.start();

  }
  
  public void run(){
    
    int margin = 50;
  
    int colsX = margin;
    int colsY = margin;
    int rectwidth = 25;
    int rectheight = 20;
    int count = 0;
    boolean column1 = true;
    Iterator j;
    PGraphicsPDF colsNeeded = (PGraphicsPDF) createGraphics((margin*2)+700, 1131, PDF, outpath+"/"+time+"_colourList.pdf");; 
    
    if(patterncode.contains("e") || patterncode.contains("h")){ //simplified

       j = complete[exportNum].simFloss.values().iterator();
       //colsNeeded = (PGraphicsPDF) createGraphics((margin*2)+700, (margin*2)+((complete[exportNum].simFloss.size()/2)*35), PDF, outpath+"/"+time+"_colourList.pdf");
       
    }else{
      
      j = complete[exportNum].conFloss.values().iterator();
      //colsNeeded = (PGraphicsPDF) createGraphics((margin*2)+700, (margin*2)+((complete[exportNum].conFloss.size()/2)*35), PDF, outpath+"/"+time+"_colourList.pdf");
    }
    
      colsNeeded.beginDraw();
      colsNeeded.smooth();
      
      while(j.hasNext()){
       
        Floss used2 = (Floss) j.next();
        colsNeeded.noStroke();
        colsNeeded.fill(used2.DMCcolor);
        colsNeeded.rect(colsX, colsY, rectwidth, rectheight);
        colsNeeded.noFill();
        colsNeeded.shape(used2.symbol, colsX+32, colsY, 20, 20);
        colsNeeded.textFont(pfont); 
        colsNeeded.text ("DMC: "+used2.identifier+"; No. of stitches: "+used2.stitches, colsX+60, colsY+15);

        colsY = colsY+35;

        if (colsY>(colsNeeded.height-75)) {
          
          if(column1){
            colsX = colsX + (colsNeeded.width/2)-20;
            colsY = margin;
            column1 = false;
          }else{
            PGraphicsPDF pdfg = (PGraphicsPDF) colsNeeded; // get renderer
            pdfg.nextPage();
            colsX = margin;
            colsY = margin;
            column1 = true;
          }
        }
      }

    println("made colorlist");
    colsNeeded.dispose();
    colsNeeded.endDraw();   
    txt.append("\ncolourList.pdf (done).."); 
    //actBar.isVisible = false;
    
  }
  
  public void stop() {

      thread = null;
    }

  public void dispose() {

      stop();
      
  }
 
 
 
  
}
