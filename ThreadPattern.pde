public class ThreadPattern implements Runnable {
  
  Thread thread;
  
  public ThreadPattern(PApplet parent) {

    parent.registerDispose(this);
  }
  
  public void start() {

    thread = new Thread(this);
    actBar.isVisible = true;
    thread.start();

  }
  
  public void run(){
    
    int margin = 50;
    int my_x = margin;
    int my_y = margin;
    boolean missing = false;
    
    PGraphicsPDF pdfPattern;
    TColor col=TColor.BLACK.copy();
    TColor liveCol = col; 
    
    pdfPattern = (PGraphicsPDF) createGraphics((margin*2)+(imgWidth*10), (margin*2)+(imgHeight*10), PDF, outpath+"/"+time+"_pattern.pdf");
    pdfPattern.beginDraw();
    pdfPattern.smooth();
    pdfPattern.noFill();
    //complete[exportNum].myImg.loadPixels();
    println("pattern pixel length: "+complete[exportNum].myImg.pixels.length);
    int ran = int(random(complete[exportNum].myImg.pixels.length));
    color randomTest = color(red(complete[exportNum].myImg.pixels[ran]),green(complete[exportNum].myImg.pixels[ran]),blue(complete[exportNum].myImg.pixels[ran]));
    println("random pixel test color: R="+red(randomTest)+" G="+green(randomTest)+" B="+blue(randomTest));

    TColor c5=TColor.BLACK.copy();
    
    for (int i = 0; i < pixelLength; i++) {

      liveCol = c5.newARGB(complete[exportNum].myImg.pixels[i]); //workImg.pixels[i]);??????????????????

      //String tempS = liveCol.toString();
      color blah = liveCol.toARGB();
      
      if(patterncode.contains("e")){ //simplified
      
        if(complete[exportNum].simFloss.containsKey(blah)){
           Floss myFloss = (Floss) complete[exportNum].simFloss.get(blah);
           pdfPattern.shape(myFloss.symbol, my_x, my_y, 10, 10);
        }else{
           println("not found: "+hex(blah)); 
           missing = true;
        }
        
      }else{ //default
        if(complete[exportNum].conFloss.containsKey(blah)){
           Floss myFloss = (Floss) complete[exportNum].conFloss.get(blah);
           pdfPattern.shape(myFloss.symbol, my_x, my_y, 10, 10);
        }else{
         println("not found: "+hex(blah));
         missing = true;
        }   
      }  
        
      pdfPattern.strokeWeight(1);
      pdfPattern.stroke(70);
      pdfPattern.rect(my_x, my_y, 10, 10);

      my_x = my_x+10;
      

      if (my_x == pdfPattern.width-50) {

        my_x=margin;
        my_y=my_y+10;
      }
    }


    //complete[exportNum].myImg.updatePixels();
    pdfPattern.dispose();
    pdfPattern.endDraw();
    if(missing){
      txt.append("\nColours missing from pattern. Export B & W and cross-check.");
    }
    println("pattern created");
    txt.append("\npattern.pdf (done)..");
    actBar.isVisible = false;
    
    
    
    
    
  }
  
  public void stop() {

      thread = null;
    }

  public void dispose() {

     
      stop();
      
  }
  
}
