void drawImage(PImage pic, int c_x, int c_y, int max_dem) {

  float ratio;
  if (pic.width>0 && pic.height>0) {

  if (broken) {

      try {

        if (pic.width > pic.height) { //A landscape

          ratio = float(max_dem)/float(pic.width);
          int imgY = int(c_y + ((max_dem/2) - (float(pic.height)*ratio)/2.0));
          //int newHeight = int(float(pic.height)*ratio);
          copy(pic, 0, 0, pic.width, pic.height, c_x, imgY, max_dem, int(float(pic.height)*ratio));
          //with image()
          //image(pic, c_x, c_y, max_dem, newHeight);
        }
        else { // A portrait or square

          ratio = float(max_dem)/float(pic.height);
          //int newWidth = int(float(pic.width)*ratio);
          int imgX = c_x + int((max_dem/2) - ((float(pic.width)*ratio)/2.0));
          copy(pic, 0, 0, pic.width, pic.height, imgX, c_y, int(float(pic.width)*ratio), max_dem);
          //with image()
          //image(pic, c_x, c_y, newWidth, max_dem);
        }
      }
      catch(Exception e) {

        println("Exception caught in method: "+e);
        broken = true;
        //CENTER
        image(brokenimage, c_x+300, c_y+300); 

      }
      //CENTER
      image(brokenimage, c_x+300, c_y+300); 
    }
    else {

      try {

        if (pic.width > pic.height) { //A landscape

          ratio = float(max_dem)/float(pic.width);
          int imgY = int(c_y + ((max_dem/2) - (float(pic.height)*ratio)/2.0));
          copy(pic, 0, 0, pic.width, pic.height, c_x, imgY, max_dem, int(float(pic.height)*ratio));
          //int newHeight = int(float(pic.height)*ratio);
          //image(pic, c_x, c_y, max_dem, newHeight);
        }
        else { // A portrait or square

            ratio = float(max_dem)/float(pic.height);
          int imgX = c_x + int((max_dem/2) - ((float(pic.width)*ratio)/2.0));
          
          //int newWidth = int(float(pic.width)*ratio);
          copy(pic, 0, 0, pic.width, pic.height, imgX, c_y, int(float(pic.width)*ratio), max_dem);
          //image(pic, c_x, c_y, newWidth, max_dem);
        }

        //broken = false;
      }
      catch(Exception e) {

        println("Exception caught in method: "+e);
        broken = true;
        image(brokenimage, c_x+300, c_y+300); 
      }
    }
  }
  else {
    broken = true;
    image(brokenimage, c_x+300, c_y+300); 
  }
}
