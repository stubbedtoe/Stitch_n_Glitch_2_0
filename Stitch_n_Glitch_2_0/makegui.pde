void makegui(){
 
 cp5 = new ControlP5(this);
 Textlabel before;
 Textlabel after;

 
 ControlFont font = new ControlFont(pfont,241);

 g1 = cp5.addGroup("Glitch")
    .setBackgroundColor(color(0,0,0,100))
    .setBackgroundHeight(380)
     ;
    
  glitch_amt = cp5.addSlider("glitch amount")
                .setPosition(10,35)
                .setSize(280,15)
                .setColorForeground(orange_passive)
                .setColorActive(orange_active)
                .setColorBackground(bg_grey)
                .setRange(0,30)
                .setValue(10)
                .setDecimalPrecision(0) 
                .moveTo(g1)
                ;
                
   //re-style + re-position labels
 cp5.getController("glitch amount")
   .getCaptionLabel()
   .align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE)
   .setPaddingX(0)
   ;
   
    cp5.getController("glitch amount")
   .getValueLabel()
   .align(ControlP5.RIGHT, ControlP5.CENTER)
   .setPaddingX(0)
   ;
   
   color_amt = cp5.addSlider("reduce colours")
                .setPosition(10,290)
                .setSize(280,15)
                .setRange(0.1,50)
                .setValue(30)
                .setDecimalPrecision(1) 
                .moveTo(g1)
                .setVisible(false)
                ;
                
   //re-style + re-position labels
 cp5.getController("reduce colours")
   .getCaptionLabel()
   .align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE)
   .setPaddingX(0)
   ;
   
    cp5.getController("reduce colours")
   .getValueLabel()
   .align(ControlP5.RIGHT, ControlP5.CENTER)
   .setPaddingX(0)
   
   ;
   
   before = cp5.addTextlabel("before","Dither Before Glitch",10,70)
         .moveTo(g1)
         ;
         
  cp5.getController("before").getValueLabel().toUpperCase(true);     
   
   dither_before = cp5.addRadioButton("dither_before")
                 .setPosition(10,90)
                 .setItemWidth(20)
                 .setItemHeight(20)
                 .addItem("bno",0)
                 .addItem("bcol",1)
                 .addItem("bbw",2)
                 .setColorLabel(color(255))
                 .activate(0)
                 .setNoneSelectedAllowed(false) 
                 .moveTo(g1)
                 ;
   
   cp5.getController("bno").setCaptionLabel("No dither");
   cp5.getController("bcol").setCaptionLabel("3-bit colour dither");
   cp5.getController("bbw").setCaptionLabel("1-bit b+w dither");
   
   d1 = cp5.addDropdownList("beforeType")
       .setPosition(140,88)
       .setSize(150,90);
       d1.getCaptionLabel().align(ControlP5.LEFT,ControlP5.CENTER);
       d1.setCaptionLabel("choose dither type");
       d1.addItem("Atkinson (default)",0);
  d1.addItem("Jarvis Judice Ninke",1);
  d1.addItem("Stucki",2);
  d1.addItem("Clustered 4X4",3);
  d1.addItem("Bayer 2x2",4);
  d1.addItem("Bayer 4x4",5);
  d1.addItem("Bayer 8x8",6);
  d1.addItem("random pattern",7);
       d1.moveTo(g1);
   d1.setItemHeight(15);
   d1.setBarHeight(15);
  // d1.setIndex(0);
   d1.setVisible(false);
   
   after = cp5.addTextlabel("after","Dither After Glitch",10,180)
         .moveTo(g1)
         ;
         
  cp5.getController("after").getValueLabel().toUpperCase(true);     
   
   dither_after = cp5.addRadioButton("dither_after")
                 .setPosition(10,200)
                 .setItemWidth(20)
                 .setItemHeight(20)
                 .addItem("ano",0)
                 .addItem("acol",1)
                 .addItem("abw",2)
                 .setColorLabel(color(255))
                 .setNoneSelectedAllowed(false) 
                 .activate(1)
                 .moveTo(g1)
                 ;
                 
   cp5.getController("ano").setCaptionLabel("No dither");
   cp5.getController("acol").setCaptionLabel("3-bit colour dither");
   cp5.getController("abw").setCaptionLabel("1-bit b+w dither");              
   
   d2 = cp5.addDropdownList("afterType")
       .setPosition(140,200)
       .setSize(150,90);
  d2.getCaptionLabel().align(ControlP5.LEFT,ControlP5.CENTER);
  d2.setCaptionLabel("choose dither type");
  d2.addItem("Atkinson (default)",0);
  d2.addItem("Jarvis Judice Ninke",1);
  d2.addItem("Stucki",2);
  d2.addItem("Clustered 4X4",3);
  d2.addItem("Bayer 2x2",4);
  d2.addItem("Bayer 4x4",5);
  d2.addItem("Bayer 8x8",6);
  d2.addItem("random pattern",7);
       d2.moveTo(g1);
   d2.setItemHeight(15);
   d2.setBarHeight(15);
  // d2.setIndex(0);
  // d2.setVisible(false);
   
   glitchButton = cp5.addButton("glitch")
     .setPosition(100,320)
     .setSize(100,50)
     .moveTo(g1);
     
   cp5.getController("glitch")
      .getCaptionLabel()
     .align(ControlP5.CENTER,ControlP5.CENTER); 
                
   g2 = cp5.addGroup("export")
                 .setBackgroundColor(color(0,100))
                 .setBackgroundHeight(380)
                 ;
                 
   choose_img = cp5.addRadioButton("radio")
                 .setPosition(104,20)
                 .setItemWidth(40)
                 .setItemHeight(40)
                 .addItem("Image 1",0)
                 .addItem("Image 2",1)
                 .addItem("Image 3",2)
                 .addItem("Image 4",3) 
                 .hideLabels()
                 .setItemsPerRow(2)
                 .activate(0)
                 .setNoneSelectedAllowed(false)
                 .moveTo(g2)
                 ;
          
    checkbox = cp5.addCheckBox("export options")
                .setPosition(10, 120)
                .setItemWidth(20)
                .setItemHeight(20)
                
                .addItem(".CSV for data vis.",0)
                .addItem(".pdf vector image",1)
                .addItem(".tiff bitmap image",2)
                //.addItem("list of colours",3) //REMOVED
                //.addItem(".PDF pattern for x-stitch",4)  //REMOVED
                //.setNoneSelectedAllowed(false) //no effect?
                //.activate(2) 
                .moveTo(g2);  
              
   patternBox = cp5.addRadioButton("pattern type")
                .setPosition(10,210)
                .setItemWidth(20)
                .setItemHeight(20)
                
                .addItem("Single page Back and white",0)
                .addItem("Multi page Back and white (default)",1)
                .addItem("Single page colour (simplified)",2)
                .addItem("Multi page colour (simplified)",3)  
                .setVisible(false)
                .moveTo(g2)
                ;
                
  
                 
   exportButton = cp5.addButton("Export")
     .setPosition(100,320)
     .setSize(100,50)
     .moveTo(g2);
     
   cp5.getController("Export")
      .getCaptionLabel()
     .align(ControlP5.CENTER,ControlP5.CENTER);
                 
  // cp5.getController("radio").getItem("Image 1").getCationLabel().setVisible(false);
                 
   accordion = cp5.addAccordion("menu")
               .setPosition(0,0)
               .setWidth(300)
               .setMoveable(false)
               .addItem(g1)
               .addItem(g2)
               .setBackgroundColor(color(0,100))
               .setColorBackground(bg_grey)
               .setColorForeground(orange_passive)
               .setColorActive(orange_active)
               .setBarHeight(15)
               ;
               
   accordion.open(0);
   accordion.setCollapseMode(Accordion.SINGLE);
   
   
   
                 
   message = cp5.addButton("message")
         .setValue(4)
         .setPosition(100,580)
         .setSize(200,200)
         .setId(2)
         .setColorForeground(orange_passive)
         .setColorBackground(orange_active)
         .setColorActive(color(0,100))
         ;
         
    message.captionLabel().hide();
   
   txt = cp5.addTextarea("txt")
             .setPosition(100, 420)
             .setSize(200,160)
             .setFont(createFont("Arial",16))
             .setLineHeight(20)
             .setColor(color(255))
             .setColorBackground(orange_active)
             .setColorForeground(bg_grey)
             .setColorActive(orange_passive)
             .setVisible(false);
             ;  
             
  //add tooltips
  //cp5.getTooltip().setDelay(500);
  cp5.getTooltip().setColorLabel(bg_grey);
  cp5.getTooltip().setColorBackground(color(255));
  cp5.getTooltip().setPositionOffset(5.0, -10.0);
  cp5.getTooltip().register("glitch amount","Err on the side of caution");
  //cp5.getTooltip().register("dither_before","dithering reduces colours");
 // cp5.getTooltip().register("dither_after","dithering reduces colours");
  cp5.getTooltip().register("reduce colours","Less = fewer colours");
  cp5.getTooltip().register("Glitch", "Glitch Options (g)");
  cp5.getTooltip().register("export", "Export Options (e)");
 // cp5.getTooltip().register("radio", "(1) (2) (3) (4)");
  cp5.getTooltip().register("message","toogle message bar (m)");
  cp5.getTooltip().register("Export", "export files (ENTER)");
  cp5.getTooltip().register("glitch", "glitch image (ENTER)");
}
