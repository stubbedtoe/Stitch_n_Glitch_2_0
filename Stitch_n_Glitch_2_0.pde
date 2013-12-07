/**********************************************************************************************************************
*    "Stitch'n'Glitch" by Andrew Healy.                                                                               * 
*    Image corruption and processing to produce cross-stitch patterns and other export options                        *             *
*    Copyright (C) 2012-2013  Andrew Healy                                                                                 *
*                                                                                                                     *
*    This program is free software: you can redistribute it and/or modify                                             *
*    it under the terms of the GNU General Public License as published by                                             *
*    the Free Software Foundation, either version 3 of the License, or                                                *
*    (at your option) any later version.                                                                              *
*                                                                                                                     *
*    This program is distributed in the hope that it will be useful,                                                  *
*    but WITHOUT ANY WARRANTY; without even the implied warranty of                                                   *
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                                                    *
*    GNU General Public License for more details.                                                                     *
*                                                                                                                     *
*    You should have received a copy of the GNU General Public License                                                *
*    along with this program.  If not, see <http://www.gnu.org/licenses/>.                                            *
*                                                                                                                     *
*    Author: Andrew Healy. Website: http://www.andrewhealy.com Email: werdnah19@gmail.com                             *
**********************************************************************************************************************/


import processing.pdf.*;


import toxi.color.*;
import toxi.color.theory.*;
import toxi.math.*;

import controlP5.*;

import java.util.Iterator;

PImage bg, brokenimage;
PImage img, workImg, corrupt, lena, working1, working2, working3, working4;
PShape[]symbols = new PShape [447];
PShape[]simple = new PShape[80];
PShape thankyou;

//GUI stuff
ControlP5 cp5;
Accordion accordion;
Slider glitch_amt, color_amt;
RadioButton choose_img, dither_before, dither_after, patternBox;
controlP5.Button message, glitchButton, exportButton;
Textarea txt;
Textlabel patternoption;
controlP5.Group g1,g2;
DropdownList d1, d2;
CheckBox checkbox;

//toxi color things
HashMap allColors; //
HashMap skeins;// = new HashMap(); //a container for all the flosses (color, name, count)
HashMap simple_skeins;// = new HashMap();
Floss[]flosses = new Floss[447];

CompleteImage[]complete = new CompleteImage[4];

TColor[]cols=new TColor[447];
ColorList palette = new ColorList();
color[] myColor = new color [447];
TColor col=TColor.BLACK.copy();

int exportNum;
float aspectRatio;
boolean isOpen=true;
color orange_active, orange_passive, bg_grey;
boolean g1_open = true;
boolean g2_open = false;
boolean broken = false;
boolean pattern, landscape, isSimple;
boolean imageLoaded = false;
boolean outputSelected = false;
boolean glitched = false;
boolean exported = false;
int imgSel= 0;
int imgWidth, imgHeight, pixelLength, max_size, max_pixels;
int actY = 400;
int dir = 1;//initial
String loadpath, stitchWidth, stitchHeight, time;
String outpath = "";
String code = "";
String patterncode = "";
byte[] byteSize;
int byteLength, b_type, a_type;
int pat_type = 0;
PFont pfont;

ActBar actBar;
ThreadGlitch glitchThis = new ThreadGlitch(this);
ThreadColorList makeColorList = new ThreadColorList(this);
ThreadPattern makePattern = new ThreadPattern(this);
ThreadMultipage makeMultipage = new ThreadMultipage(this);

void setup(){
 
  HashMap dummy1 = new HashMap();
  HashMap dummy2 = new HashMap(); 
  frame.setTitle("Stitch'n'Glitch");
  
  size(900,600);
  brokenimage = loadImage("brokenimage.png");
  bg = loadImage("bg.jpg");
  PImage blank = createImage(1,1,ARGB);
  blank.loadPixels();
  blank.pixels[0]=color(0,0);
  blank.updatePixels();
  thankyou = loadShape("thankyou.svg");
  for(int i=0; i<4; i++){
    complete[i] = new CompleteImage(blank, dummy1, false, dummy2, false);
  }


  background(bg);
  noStroke();
  smooth();
  orange_passive = color(255,190,20);
  orange_active = color(255,210,30);
  bg_grey = color(0,0,30);
  imageMode(CENTER);
  pfont = createFont("Arial",18,true);
  makegui();
  
  //make actBar and it is invisible
  actBar = new ActBar(false);
  
  //load simple shapes
  for(int i=0; i<80; i++){
  
    simple[i] = loadShape("simple"+i+".svg");
    
  }
  
  
  
  //make all my floss objects
  allColors = new HashMap();
  String[]preferences = loadStrings("preferences.txt");
  
  String[]string_size = split(preferences[0],' ');
  max_size = int(string_size[string_size.length-1]);
  String[]string_pixels = split(preferences[1],' '); 
  max_pixels = int(string_pixels[string_pixels.length-1]);
  String[]tempStrings = loadStrings("straightnumbers.txt");

  for (int i = 0; i < 447; i++) {

    String[]lineString = split(tempStrings[i], ',');

    myColor[i] = color(unhex(lineString[1]));

    cols[i]=col.newARGB(myColor[i]);
    //palette.add(col.newARGB(myColor[i]));
    palette.add(cols[i]);
    symbols[i]=loadShape("symbol"+i+".svg");

    flosses[i] = new Floss(lineString[0], myColor[i], symbols[i]);
    allColors.put(cols[i], flosses[i]);
  }
  
  selectInput("Select an image (RGB jpeg preferred)", "loadFile");

}

void loadFile(File selection) {

  if (selection == null) {

    println("Window was closed or the user hit cancel.");
    img = loadImage("lenacrop.jpg");
    
    pattern = true;
    imgWidth = img.width;
    imgHeight = img.height;
    txt.setText("This is the default image ("+imgWidth+" x "+imgHeight+"px)");
    pixelLength = img.pixels.length;
    if (imgWidth>imgHeight) {
      landscape = true;
      aspectRatio = float(imgWidth)/float(imgHeight);
    }
    else {
      landscape = false;
      aspectRatio = float(imgHeight)/float(imgWidth);
    }
    workImg=new PImage(imgWidth, imgHeight, ARGB);

    imageLoaded = true;
  } 
  else {

    println("User selected " + selection.getAbsolutePath());
    loadpath = selection.getAbsolutePath();
    String [] splits = split (selection.getAbsolutePath(), '/');
    String filename = splits[splits.length - 1];
    String [] getformat = split (filename, '.');
    String format = getformat[getformat.length-1];
    println ("Filename: "+filename+" : Format: "+format);

    if (format.equalsIgnoreCase("jpg") || format.equalsIgnoreCase("gif") || format.equalsIgnoreCase("jpeg")) {


        img = loadImage(loadpath);
        imgWidth = img.width;
        imgHeight = img.height;
        txt.setText(filename+" ("+imgWidth+" x "+imgHeight+"px)");
        pixelLength = img.pixels.length;
        if (imgWidth>imgHeight) {
          landscape = true;
          aspectRatio = float(imgHeight)/float(imgWidth);
        }
        else {
          landscape = false;
          aspectRatio = float(imgWidth)/float(imgHeight);
        }
        workImg=createImage(imgWidth, imgHeight, ARGB);

        //img.save("./data/origImg."+format);
        byteSize = loadBytes(loadpath);
        byteLength = byteSize.length;
        //100000 || pixelLength > 200000
        if(byteLength > max_size || pixelLength > max_pixels){
         
          txt.append("\n\nThis image is too large to fully Stitch'n'Glitch");
          pattern = false;
          
          
        }else{
          txt.append("\n\nThis image is small enough for Stitch'n'Glitch to create a .pdf pattern");
          pattern = true;
          
        }
        //inputSelected = true;
        imageLoaded = true;
      }
    
    else {//not an image
      selectInput("Select an image (RGB jpeg preferred)", "loadFile");
    }
  }
}



void draw(){
 background(bg);
 
 if(g1.isOpen()){
   g1_open = true;
   g2_open = false;
   exported = false;
 }
 
 if(g2.isOpen()){
   g2_open = true;
   g1_open = false; 
 }
 
 if(imageLoaded){
 
   if(g1_open){

     //boolean for adjusted....
     if(glitched){
       drawImage(workImg, 300, 0, 600);
     }else{
       drawImage(img, 300,0,600);
     }
   }
   
   if(g2_open){
     
     /*
     drawImage(complete[0].myImg, 300, 0, 300);
     drawImage(complete[1].myImg, 600, 0, 300);
     drawImage(complete[2].myImg, 300, 300, 300);
     drawImage(complete[3].myImg, 600, 300, 300);
     */
     
     if(landscape){
       image(complete[0].myImg, 450, 150, 300, 300.0*aspectRatio);
       image(complete[1].myImg, 750, 150, 300, 300.0*aspectRatio);
       image(complete[2].myImg, 450, 450, 300, 300.0*aspectRatio);
       image(complete[3].myImg, 750, 450, 300, 300.0*aspectRatio);
     }else{
       image(complete[0].myImg, 450, 150, 300.0*aspectRatio, 300);
       image(complete[1].myImg, 750, 150, 300.0*aspectRatio, 300);
       image(complete[2].myImg, 450, 450, 300.0*aspectRatio, 300);
       image(complete[3].myImg, 750, 450, 300.0*aspectRatio, 300);
     }
     
     
     
     switch(imgSel){
       case(0):
         
         fill(orange_passive,75);
         rect(300,0,300,300);

         patternBox.setVisible(complete[0].canPat);
         if(complete[0].simPat){
          patternBox.getItem(2).setVisible(true);
          patternBox.getItem(3).setVisible(true);
         }else{
          patternBox.getItem(2).setVisible(false);
          patternBox.getItem(3).setVisible(false);
         }
         break;
       case(1):
         fill(orange_passive,75);
         rect(600,0,300,300);

         patternBox.setVisible(complete[1].canPat);
         if(complete[1].simPat){
          patternBox.getItem(2).setVisible(true);
          patternBox.getItem(3).setVisible(true);
         }else{
          patternBox.getItem(2).setVisible(false);
          patternBox.getItem(3).setVisible(false);
         }
         break;
        case(2):
         
         stroke(orange_passive,75);
         rect(300,300,300,300);
         patternBox.setVisible(complete[2].canPat);

         if(complete[2].simPat){
          patternBox.getItem(2).setVisible(true);
          patternBox.getItem(3).setVisible(true); 
         }else{
          patternBox.getItem(2).setVisible(false);
          patternBox.getItem(3).setVisible(false);
         }
         break;
       case(3):
         fill(orange_passive,75);
         rect(600,300,300,300);
         patternBox.setVisible(complete[3].canPat);
         if(complete[3].simPat){
          patternBox.getItem(2).setVisible(true);
          patternBox.getItem(3).setVisible(true);  
         }else{
          patternBox.getItem(2).setVisible(false);
          patternBox.getItem(3).setVisible(false); 
         }
         break;
       }
   }
   
   if(actBar.isVisible){
   
     if(actY > height-32 || actY < 400){
       dir *= -1;
     }
   
     actBar.move(actY,dir);  
     actY += dir*3;
     
   }
 }
 
 if(glitched){
   if(!exported){
    if(g2_open && imgSel<4 && !actBar.isVisible){
     txt.setText("No. of colours: "+complete[imgSel].conFloss.size()
       +"\n\nSize: "+stitchWidth+" x "+stitchHeight+" on 14ct fabric");
    }else{
     if(!broken && !actBar.isVisible){
       txt.setText("No. of colours: "+complete[0].conFloss.size()
       +"\n\nSize: "+stitchWidth+" x "+stitchHeight+" on 14ct fabric");  
     }
    }
   }
 } 
 
 
 
 message.position().y += ((isOpen==true ? 400 : 580) - message.position().y) *0.2; 
 
  
}

void saveCSVfile(){
  
  PrintWriter output = createWriter(outpath+"/"+time+"_data.csv");
  int x_pos = 0;
  actBar.isVisible = true;

  complete[exportNum].myImg.loadPixels();

  for (int i = 0; i < pixelLength; i++) {

    String temp = hex(complete[exportNum].myImg.pixels[i]);

    if (x_pos>imgWidth) {
      output.println(temp+",");
      x_pos = 0;
    }
    else {
      output.print(temp+",");
    }

    x_pos++;
  }

  complete[exportNum].myImg.updatePixels();
  output.close();
  println("made csv");
  txt.append("\ndata.csv (done)..");
  actBar.isVisible = false;

  
}

void savePDFimage() {

  actBar.isVisible = true;
  int margin = 10; 

  PGraphicsPDF pdf = (PGraphicsPDF) createGraphics((margin*2)+imgWidth, (margin*2)+imgHeight, PDF, outpath+"/"+time+"_vector.pdf"); 

  int my_x = margin;
  int my_y = margin; 

  complete[exportNum].myImg.loadPixels();

  pdf.beginDraw();
  pdf.smooth();
  pdf.noStroke();

  for (int i=0; i< pixelLength; i++) {

    color tempCol = complete[exportNum].myImg.pixels[i];
    pdf.fill(tempCol);
    pdf.rect(my_x, my_y, 1, 1);

    my_x = my_x+1;

    if (my_x > (pdf.width-(margin+1))) {

      my_x=margin;
      my_y=my_y+1;
    }
  }

  complete[exportNum].myImg.updatePixels();

  pdf.dispose();
  pdf.endDraw();
  actBar.isVisible = false;
  println("made pdf image");
  txt.append("\nvector.pdf (done)..");

}

public void doExport(int sel){
  
   exported = true;
   exportNum = sel;
   //actBar.isVisible = true;
   String[]folders = split(outpath, "/");
  
   println("export "+code+" now");
   String[] year = split(str(year()) , '0');
   time = year[1]+str(month())+str(hour())+str(hour())+str(minute())+str(second());
   txt.setText("File(s)  to be saved at .../"+folders[folders.length-2]+"/"+folders[folders.length-1]+"/"+time+"_\n");  
     
   if(code.contains("c")){
     
     //CSV
     
     thread("saveCSVfile");
        
   }
   
   if(code.contains("i")){
    
      //PDF image 
      
      thread("savePDFimage");
   }
   
   if(code.contains("t")){
    
    //tiff image
     
     complete[exportNum].myImg.save(outpath+"/"+time+"_image.tiff"); 
     txt.append("\nimage.tiff (done)..");
   }
   
   if(patterncode.contains("s") || patterncode.contains("e")){
   
     makeColorList.start();
     makePattern.start();
   }
   
   
   if(patterncode.contains("m") || patterncode.contains("h")){
    
    makeColorList.start(); 
    makeMultipage.start(); 
     
   }
  
}

public void setOutPath(File folder){
  
   if (folder != null){
    
    outpath = folder.getAbsolutePath();
    outputSelected = true;
    doExport(imgSel);
  }
  
}

void keyPressed() {
  switch(key) {
    case('g'): accordion.close(); g1.open(); break;
    case('e'): accordion.close(); g2.open(); break;
    case('m'): isOpen = !isOpen; txt.setVisible(!txt.isVisible()); break;
    case('x'): isOpen = false; accordion.close(); txt.setVisible(false); break;
    case('1'): radio(0); choose_img.activate(0); break;
    case('2'): radio(1); choose_img.activate(1); break;
    case('3'): radio(2); choose_img.activate(2); break;
    case('4'): radio(3); choose_img.activate(3); break;
    case(ENTER):
      if(g1_open){
        if(!actBar.isVisible){
          println("glitchThis"); 
          actBar.setVisible(true);
          exported = false;
          glitchThis.start(); 
        }
      }else{
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
      break;
  }
}

void mousePressed(){
 
 if(g2_open){
  if(mouseX>300){
    if(mouseX < 600 && mouseY < 300){ //image one
      radio(0); choose_img.activate(0);
    }else if(mouseX > 600 && mouseY < 300){ //image two
      radio(1); choose_img.activate(1);
    }else if(mouseX < 600 && mouseY > 300){ //image three
      radio(2); choose_img.activate(2);
    }else if(mouseX > 600 && mouseY > 300){ //image four
     radio(3); choose_img.activate(3); 
    }
  }
 } 
}


