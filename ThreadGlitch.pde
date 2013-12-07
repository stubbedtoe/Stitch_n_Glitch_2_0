public class ThreadGlitch implements Runnable {

  Thread thread;
  HashMap convien = new HashMap();

  boolean running = false;

  public ThreadGlitch(PApplet parent) {

    parent.registerDispose(this);
  }

  public void start() {

    thread = new Thread(this);
    thread.start();
    running = true;
    broken = false;
  }

  public void run() {

    TColor liveCol = TColor.BLACK.copy();
    ColorList some = new ColorList();
    //skeins.clear();

    if (dither_before.getItem(1).getState()) { //colour dither before

        println("colour dither before glitch selected. Type: "+b_type);
      txt.setText("Dithering before Glitch..");
      switch(b_type) {
        case(0): workImg = atkin(img, 1); break; 
        case(1): workImg = jarvis(img, 1); break;
        case(2): workImg = stucki(img, 1); break; 
        case(3): workImg = clustered(img, 1); break;
        case(4): workImg = bayer2(img, 1); break;
        case(5): workImg = bayer4(img, 1); break;
        case(6): workImg = bayer8(img, 1); break;
        case(7): workImg = randomPattern(img, 1); break;
      default: workImg = atkin(img, 1); break;
      }

      workImg.save(sketchPath("SngAppData/adjusted.jpg"));//let's try a tiff
    }
    else if (dither_before.getItem(2).getState()) { //b+w dither before

        txt.setText("Dithering before Glitch..");
      println("B&W dither before glitch selected. Type: "+b_type);

       switch(b_type) {
        case(0): workImg = atkin(img, 0); break; 
        case(1): workImg = jarvis(img, 0); break;
        case(2): workImg = stucki(img, 0); break; 
        case(3): workImg = clustered(img, 0); break;
        case(4): workImg = bayer2(img, 0); break;
        case(5): workImg = bayer4(img, 0); break;
        case(6): workImg = bayer8(img, 0); break;
        case(7): workImg = randomPattern(img, 0); break;
      default: workImg = atkin(img, 0); break;
      }

      workImg.save(sketchPath("SngAppData/adjusted.jpg"));//let's try a tiff
    }
    else {//do nothing for no glitch

      txt.setText("No dither before glitch");
      workImg.copy(img, 0, 0, imgWidth, imgHeight, 0, 0, imgWidth, imgHeight);

      workImg.save(sketchPath("SngAppData/adjusted.jpg"));
    }


    //glitch

      txt.append("\nApplying Glitch (if any)..");
    byte bits [] = loadBytes(sketchPath("SngAppData/adjusted.jpg"));
    byte bCopy [] = new byte[bits.length];
    arrayCopy(bits, bCopy);
    int scrambleStart = 10;
    int scrambleEnd = bits.length;
    int numReplacements = int(glitch_amt.getValue());

    println("number for glitch: "+numReplacements);

    for (int i = 0; i < numReplacements; i++) {

      int PosA = int(random (scrambleStart, scrambleEnd));

      int PosB = int(random (scrambleStart, scrambleEnd));

      byte tmp = bCopy[PosA];

      bCopy[PosA] = bCopy[PosB];

      bCopy[PosB] = tmp;
    }

    saveBytes(sketchPath("SngAppData/corrupt.jpg"), bCopy);
    corrupt=loadImage(sketchPath("SngAppData/corrupt.jpg"));



    try {

      //dither after
      if (dither_after.getItem(1).getState()) { //colour dither before

          txt.append("\nDithering after Glitch..");
        switch(a_type) {
          case(0): corrupt = atkin(corrupt, 1); break;
          case(1): corrupt = jarvis(corrupt, 1); break;
          case(2): corrupt = stucki(corrupt, 1); break; 
          case(3): corrupt = clustered(corrupt, 1); break;
          case(4): corrupt = bayer2(corrupt, 1); break;
          case(5): corrupt = bayer4(corrupt, 1); break;
          case(6): corrupt = bayer8(corrupt, 1); break;
          case(7): corrupt = randomPattern(corrupt, 1); break;
        default: corrupt = atkin(corrupt, 1); break;
        }

        //workImg.save(sketchPath("SngAppData/corrupt.jpg"));//let's try a tiff
      }
      else if (dither_after.getItem(2).getState()) { //b+w dither before

          txt.append("\nDithering after Glitch..");
        switch(a_type) {
          case(0): corrupt = atkin(corrupt, 0); break;
          case(1): corrupt = jarvis(corrupt, 0); break;
          case(2): corrupt = stucki(corrupt, 0); break; 
          case(3): corrupt = clustered(corrupt, 0); break;
          case(4): corrupt = bayer2(corrupt, 0); break;
          case(5): corrupt = bayer4(corrupt, 0); break;
          case(6): corrupt = bayer8(corrupt, 0); break;
          case(7): corrupt = randomPattern(corrupt, 0); break;
        default: corrupt = atkin(corrupt, 0); break;
        }


        //workImg.save("./SnGappData/adjusted.tiff");//let's try a tiff
        //workImg.save(sketchPath("SngAppData/corrupt.jpg"));
      }
      else {//no glitch after



        //txt.append("\nCounting colours: "+skeins.size());

        if (pattern) {

          //reduce colors
          if (color_amt.getValue() < 50.0) {

            txt.append("\nReducing colours..");

            float tolerance = 0.5 - (color_amt.getValue()/100.0);
            corrupt.loadPixels();

            Histogram hist = Histogram.newFromARGBArray(corrupt.pixels, pixelLength, tolerance, false);
            println("tolerance: "+tolerance);
            TColor c2=TColor.BLACK.copy();

            for (int i=0; i< pixelLength; i++) {

              c2.setARGB(corrupt.pixels[i]);

              TColor closest=c2;
              float minD=1;
              for (HistEntry e : hist) {


                float d=c2.distanceToRGB(e.getColor());

                if (d<minD) {
                  minD=d;
                  closest=e.getColor();
                }
              }

              corrupt.pixels[i]=closest.toARGB();
              corrupt.updatePixels();
            }
          }
        

        corrupt.loadPixels();
        workImg.loadPixels();

        txt.append("\nUpdating pixels..");
        
        }
        
      }
        
        if(pattern){


        skeins = new HashMap();

        //make the full skeins list of objects
        for (int j = 0; j < pixelLength; j++) {

          color blah = corrupt.pixels[j];
          liveCol = col.newARGB(blah);
          some = palette.sortByProximityTo(liveCol, false);
          liveCol = some.get(0);
          //used.add(liveCol);
          blah = liveCol.toARGB();
          String temp = liveCol.toString();
          // println("working key: "+temp);
          if (skeins.containsKey(blah)) {
            Floss f = (Floss) skeins.get(blah);
            f.count();
          }
          else {
            Floss f = (Floss) allColors.get(liveCol);
            skeins.put(blah, f);
          }
          //and change the preview
          workImg.pixels[j] = blah;//liveCol.toARGB();
        }



        workImg.updatePixels();
        corrupt.updatePixels();

        //put into a smaller, newer array of simple floss objects
        if (skeins.size() <= 80) {


          simple_skeins = new HashMap();
          HashMap temps = new HashMap();
          Iterator j = skeins.values().iterator();
          IntList mostStitches = new IntList();

          while (j.hasNext ()) {

            Floss s_floss = (Floss)j.next();
            //Floss u_floss = new Floss ()
            temps.put(s_floss.stitches, s_floss);
            mostStitches.append(s_floss.stitches);
          }

          mostStitches.sortReverse();//highest to lowest

          //put into HashMap
          for (int i = 0; i<mostStitches.size(); i++) {

            int nextBiggest = mostStitches.get(i);
            Floss f = (Floss) temps.get(nextBiggest);
            Floss g = new Floss(f.identifier, f.DMCcolor, simple[i]);
            g.stitches = f.stitches;
            //f.resetSymbol(simple[i]); //reseting symbols
            color blah = g.DMCcolor;
            simple_skeins.put(blah, g);
          }



          println("Most stitches: "+mostStitches.get(0));
          CompleteImage finished = new CompleteImage(workImg, skeins, pattern, simple_skeins, true);
          complete = (CompleteImage[]) reverse(complete);
          complete = (CompleteImage[]) append(complete, finished); 
          complete = (CompleteImage[]) reverse(complete);
          complete = (CompleteImage[]) shorten(complete);
        }
        else {
          //
          HashMap dummy = new HashMap();
          CompleteImage finished = new CompleteImage(workImg, skeins, pattern, dummy, false); 
          complete = (CompleteImage[]) reverse(complete);
          complete = (CompleteImage[]) append(complete, finished); 
          complete = (CompleteImage[]) reverse(complete);
          complete = (CompleteImage[]) shorten(complete);
        }
      }
      else { //don't bother if not (pattern)



        HashMap convien = new HashMap(); //to count colours only

        //Find Number of colours (for convienience)
        for (int j = 0; j < pixelLength; j++) {

          color blah = corrupt.pixels[j];
          workImg.pixels[j] = blah;

          String temp = hex(blah);
          if (!convien.containsKey(temp)) {
            convien.put(temp, blah);
          }
        }

        workImg.updatePixels();
        corrupt.updatePixels();

        skeins = new HashMap (convien.size());
        HashMap dummy = new HashMap();
        CompleteImage finished = new CompleteImage(workImg, convien, pattern, dummy, false); 
        complete = (CompleteImage[]) reverse(complete);
        complete = (CompleteImage[]) append(complete, finished); 
        complete = (CompleteImage[]) reverse(complete);
        complete = (CompleteImage[]) shorten(complete);
      } 
    



      float sW = float(imgWidth)/14.0;
      float sH = float(imgHeight)/14.0;
      stitchWidth = nf(sW, 2, 2)+"\'\'";
      stitchHeight = nf(sH, 2, 2)+"\'\'";

      println("Number of colours in Glitch: "+skeins.size());
      txt.setText("No. of colours: "+skeins.size()+"\n\nSize: "+stitchWidth+" x "+stitchHeight+" on 14ct fabric");

      if (skeins.size()==1) {
        txt.setText("Image is broken");
        broken=true;
      }
    }
    catch(Exception e) {

      println("Another exception caught: "+e);
      txt.setText("Image is broken");
      broken = true;
      image(brokenimage, 600, 300);
    }

    //workImg.save(sketchPath("SnGappData/workImg.tif"));
    println("is broken? "+broken);
    glitched = true;
    actBar.setVisible(false);
    //broken = false;
  }

  public void stop() {

    thread = null;
  }

  public void dispose() {


    stop();
  }
}

