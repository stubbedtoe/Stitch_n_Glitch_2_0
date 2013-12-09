public class ThreadMultipage implements Runnable {
  
  Thread thread;
  PGraphicsPDF pdf;
  
  public ThreadMultipage(PApplet parent) {

    parent.registerDispose(this);
  }
  
  public void start() {

    thread = new Thread(this);
    actBar.isVisible = true;
    thread.start();

  }
  
  public void run(){
    
    boolean missing = false;
    int margin = 10;
    int pos_x;
    int pos_y;
    int sym_x = 30;
    int sym_y = 40;
    int pageNum = 0;
    boolean overflowX;
    boolean overflowY;
    float ratio;
    int img_top, img_bottom, img_left, img_right;
    
    int pagesWide;
    int pagesHigh;
    int max_x = sym_x;
    int max_y = sym_y;

    TColor col=TColor.BLACK.copy();
    TColor liveCol = col; 
    TColor c5=TColor.BLACK.copy();
    
    if(imgWidth%sym_x != 0){
      pagesWide = int(imgWidth/sym_x) +1; //rounded up  
      overflowX = true;
    }else{
      pagesWide = int(imgWidth/sym_x); 
      overflowX = false;
    }
    if(imgHeight%sym_y != 0){
      pagesHigh = int(imgHeight/sym_y) +1; //rounded up  
      overflowY = true;
    }else{
      pagesHigh = int(imgHeight/sym_y); 
      overflowY = true;
    }
    
    int [] startX = new int[pagesWide];
    int [] startY = new int[pagesHigh];
    
    for(int w =0; w<pagesWide; w++){ 
      startX[w] = sym_x*w;
    }
    for(int h=0; h<pagesHigh; h++){
     startY[h] = sym_y*h; 
    }
    
    println("pages wide: "+pagesWide);
    println("pages high: "+pagesHigh);
    
    //A4 proportion (approx)
    pdf= (PGraphicsPDF) createGraphics((sym_x*10)+20, 453, PDF, outpath+"/"+time+"_pattern.pdf");
    pdf.beginDraw();
    pdf.smooth();
    pdf.noFill();
    
    //image start page
    pdf.shape(thankyou, pdf.width-135, pdf.height-60, 125, 50);
    pdf.fill(70);
    pdf.textFont(pfont); 
    pdf.textSize(10);
    pdf.textAlign(RIGHT);
    pdf.text ("stitch-n-glitch.com", pdf.width-10, 20);
    
    pdf.imageMode(CENTER);
    if(landscape){  
       ratio = float(200)/float(imgWidth);
       img_top = pdf.height/2 - int(imgHeight*ratio)/2;
       img_bottom = pdf.height/2 + int(imgHeight*ratio)/2;
       img_left = pdf.width/2 - 100;
       img_right = pdf.width/2 + 100;
       
       pdf.image(complete[exportNum].myImg, pdf.width/2, pdf.height/2, 200, int(imgHeight*ratio));
             
    }else{
      ratio = float(200)/float(imgHeight);
      img_top = pdf.height/2 - 100;
      img_bottom = pdf.height/2 +100;
      img_left = pdf.width/2 - int(imgWidth*ratio)/2;
      img_right = pdf.width/2 + int(imgWidth*ratio)/2;
      
      pdf.image(complete[exportNum].myImg, pdf.width/2, pdf.height/2, int(imgWidth*ratio), 200);
     
    }
    float page_sizeX = float(sym_x)*ratio;
    float page_sizeY = float(sym_y)*ratio;
    float plocY = float(img_top)+page_sizeY;
    float plocX = float(img_left)+page_sizeX;
    
    for(int pX = 0; pX < pagesWide-1; pX++){     
        pdf.stroke(0,255,255);
        pdf.line(plocX, img_top-10, plocX, img_bottom+10);
        plocX += page_sizeX; 
        println("plocX ="+plocX);
     }
     for(int pY = 0; pY < pagesHigh-1; pY++){  
        pdf.stroke(0,255,255);
        pdf.line(img_left-10, plocY, img_right+10, plocY);
        plocY += page_sizeY; 
        println("plocY ="+plocY);
     }
    
    //drawImage(complete[exportNum].myImg, pdf.width/2, pdf.height/2, 200);
    
    next_page();

    println("pattern pixel length: "+complete[exportNum].myImg.pixels.length);
    int ran = int(random(complete[exportNum].myImg.pixels.length));
    color randomTest = color(red(complete[exportNum].myImg.pixels[ran]),green(complete[exportNum].myImg.pixels[ran]),blue(complete[exportNum].myImg.pixels[ran]));
    println("random pixel test color: R="+red(randomTest)+" G="+green(randomTest)+" B="+blue(randomTest));

    //if(pageNum>0){
    
    for(int pageY=0; pageY < pagesHigh; pageY++){
     for(int pageX=0; pageX < pagesWide; pageX++){

       int locY = startY[pageY];
       int locX = startX[pageX];
       
       int textNum = pageNum+1;
       pos_x = 10;
       pos_y = 40;
       
       pdf.fill(70);
       pdf.text ("Page "+textNum, pdf.width-10, 20);
       pdf.noFill();
   
       if(overflowX && overflowY){
         if(pageX==pagesWide-1 && pageY==pagesHigh-1){
           max_y = imgHeight%sym_y;
           max_x = imgWidth%sym_x;
         }else if(pageX==pagesWide-1){
           max_x = imgWidth%sym_x;
           max_y = sym_y; 
         }else if(pageY==pagesHigh-1){
           max_y = imgHeight%sym_y; 
           max_x = sym_x;
         }else{
          max_x = sym_x;
          max_y = sym_y; 
         }
       }else if(overflowX){
         if(pageX==pagesWide-1){
          max_x = imgWidth%sym_x;
          max_y = sym_y; 
         }else{
          max_x = sym_x;
          max_y = sym_y; 
         } 
       }else if(overflowY){
         if(pageY==pagesHigh-1){
          max_y = imgHeight%sym_y; 
          max_x = sym_x;
         }else{
           max_y = sym_y;
           max_x = sym_x;
         }
       }else{
        max_x = sym_x;
        max_y = sym_y; 
       }
       
       println("Starting from: ("+locX+","+locY+") for "+max_x+" px x "+max_y+" px");
       //now each page
       for(int y = locY; y < max_y + locY; y++){
        for(int x = locX; x < max_x + locX; x++){
          
          liveCol = c5.newARGB(complete[exportNum].myImg.get(x,y));//
           color blah = liveCol.toARGB();
           
           //println(hex(blah));
           
           if(patterncode.contains("h")){//colour    //experiment to remove the requirement of checking...
             
             if(complete[exportNum].simFloss.containsKey(blah)){
               Floss myFloss = (Floss) complete[exportNum].simFloss.get(blah);
               pdf.shape(myFloss.symbol, pos_x, pos_y, 10, 10);
             }else{
              missing = true; 
              println("not found: "+hex(blah)); 
             }
           }else{
             if(complete[exportNum].conFloss.containsKey(blah)){
               Floss myFloss = (Floss) complete[exportNum].conFloss.get(blah);
               pdf.shape(myFloss.symbol, pos_x, pos_y, 10, 10);
             }else{
               missing = true;
               println("not found: "+hex(blah)); 
             }
           }
           
           
           
           pdf.strokeWeight(1);
           pdf.stroke(70);
           pdf.rect(pos_x, pos_y, 10,10);
           
          if(pos_x==margin+(max_x-1)*10){
           pos_x = 10;
           pos_y += 10; 
          }else{
           pos_x += 10; 
          }

        } 
       }
   
       
       pageNum++;
       if(pageNum != pagesWide*pagesHigh ){
         next_page();
        //PGraphicsPDF pdfg = (PGraphicsPDF) pdf; // get renderer
        //pdfg.nextPage(); // tell it to go to the next page 
       }
       
       //println("Completed Page Number "+pageNum); 

     }
     

    }
    
    
    println("pages to be done: "+pagesWide*pagesHigh);
    if(missing){
      txt.append("\nColours missing from pattern. Export B & W and cross-check.");
    }
    pdf.dispose();
    pdf.endDraw();
    println("pattern created");
    txt.append("\npattern.pdf (done)..");
    actBar.isVisible = false;
    
    
    
    
    
  }
  
  public void next_page(){
    
    PGraphicsPDF pdfg = (PGraphicsPDF) pdf; // get renderer
    pdfg.nextPage(); // tell it to go to the next page 
    
  }
  
  public void stop() {

      thread = null;
    }

  public void dispose() {

     
      stop();
      
  }
  
}
