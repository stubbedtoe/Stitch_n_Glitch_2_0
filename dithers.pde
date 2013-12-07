/* Floyd doesn't work properly
PImage floyd (PImage r, int mode){
  
  int [] f_loc = new int [4];
 // float [] w = new float [4];
  PImage _img = new PImage(r.width, r.height, ARGB);
  float diffred = 0.0;
  float diffgreen = 0.0;
  float diffblue = 0.0;
  float diff = 0.0;

  _img.copy(r,0,0,imgWidth,imgHeight,0,0,imgWidth,imgHeight);
  _img.loadPixels();

  
  
  for (int x = 0; x < imgWidth; x++) {
    for (int y = 0; y < imgHeight; y++) {
      
      int loc1 = x+y*imgWidth;//origin
      
      if(mode==1){//color
        
        float ored = (_img.pixels[loc1] >> 16) & 0xFF; //fast red
        float ogreen = (_img.pixels[loc1] >> 8) & 0xFF; //fast green
        float oblue = _img.pixels[loc1] & 0xFF;//fast blue
        
        float nred = ored<128 ? 0 : 255;
        float nblue = oblue<128 ? 0 : 255;
        float ngreen = ogreen<128 ? 0 : 255;
        
        diffred = ored - nred;
        diffgreen = ogreen - ngreen;
        diffblue = oblue - nblue;

       
     
      }else{//b&w
      
        float obright = brightness(_img.pixels[loc1]);
        float nbright = obright<128 ? 0 : 255;
        diff = obright-nbright;
      
      
      }
      
      //f-s locations
      f_loc[0] = loc1+1;//right of origin
      f_loc[1] = loc1+(imgWidth-1);
      f_loc[2] = loc1+imgWidth;//under origin
      //f_loc[1] = f_loc[2]-1;//bottom left of origin
      f_loc[3] = f_loc[2]+1;//bottom right of origin
      
      for(int i=0; i<f_loc.length; i++){
       if(f_loc[i] < pixelLength){
         
         color fs;
         float w =0.0;
         
         if(i==0){
          w=7.0/16; 
         }else if(i==1){
          w=3.0/16;
         }else if(i==2){
          w=5.0/16;
         }else if(i==3){
          w = 1.0/16;
         }
         
         if(mode==1){//color
           fs = color(((_img.pixels[f_loc[i]] >> 16) & 0xFF)+w * diffred, 
                   ((_img.pixels[f_loc[i]] >> 8) & 0xFF)+w * diffgreen, 
                   (_img.pixels[f_loc[i]] & 0xFF)+w * diffblue);
         }else{//b&w
           fs = color(brightness(_img.pixels[f_loc[i]])+w * diff);
         }
          
         _img.pixels[f_loc[i]] = fs; 
          
       } 
      }
 
    }
  }
  
  for(int i=0;i<pixelLength;i++){
     
     int roundred = (_img.pixels[i] >> 16) & 0xFF; 
     roundred = roundred< 128 ? 0 : 255;
     int roundgreen = (_img.pixels[i] >> 8) & 0xFF;
     roundgreen = roundgreen < 128 ? 0 : 255;
     int roundblue = _img.pixels[i] & 0xFF; 
     roundblue = roundblue < 128 ? 0 : 255;

     _img.pixels[i] = color(roundred,roundgreen,roundblue);

  }
  
  _img.updatePixels();
  return _img;
    
}

*/

PImage atkin (PImage r, int mode){
  
  int [] a_loc = new int [6];
  float at = 1.0/8;
  PImage _img = new PImage(r.width, r.height, ARGB);
  float diffred = 0.0;
  float diffgreen = 0.0;
  float diffblue = 0.0;
  float diff = 0.0;
  _img.copy(r,0,0,imgWidth,imgHeight,0,0,imgWidth,imgHeight);
  _img.loadPixels();
  
  
  
  for (int x = 0; x < imgWidth; x++) {
    for (int y = 0; y < imgHeight; y++) {
      
      int loc1 = x+y*imgWidth;//origin
      
      
      if(mode==1){//color
        
        float ored = (_img.pixels[loc1] >> 16) & 0xFF; //fast red
        float ogreen = (_img.pixels[loc1] >> 8) & 0xFF; //fast green
        float oblue = _img.pixels[loc1] & 0xFF;//fast blue
        
        float nred = ored<128 ? 0 : 255;
        float nblue = oblue<128 ? 0 : 255;
        float ngreen = ogreen<128 ? 0 : 255;
        
        diffred = ored - nred;
        diffgreen = ogreen - ngreen;
        diffblue = oblue - nblue;

        _img.pixels[loc1] = color(nred,ngreen,nblue);
     
      }else{//b&w
      
        float obright = brightness(_img.pixels[loc1]);
        float nbright = obright<128 ? 0 : 255;
        diff = obright-nbright;
      
        _img.pixels[loc1] = color(nbright);
      }
      
      //atkin locations
      a_loc[0] = loc1+1;
      a_loc[1] = loc1+2;
      a_loc[2] = (loc1+imgWidth)-1;//bottom left(alternate)
      a_loc[3] = a_loc[2]+1;//under origin(alternate)
      a_loc[4] = a_loc[3]+1;// 2 to the right of origin
      a_loc[5] = loc1+(imgWidth*2);//2 under origin  
      
      for(int i=0; i<a_loc.length; i++){
       if(a_loc[i] < pixelLength){
         
         color fs;
         
         if(mode==1){//color
           fs = color(((_img.pixels[a_loc[i]] >> 16) & 0xFF)+at * diffred, 
                   ((_img.pixels[a_loc[i]] >> 8) & 0xFF)+at * diffgreen, 
                   (_img.pixels[a_loc[i]] & 0xFF)+at * diffblue);
         }else{//b&w
           fs = color(brightness(_img.pixels[a_loc[i]])+at * diff);
         }
          
         _img.pixels[a_loc[i]] = fs; 
          
       } 
      }
 
    }
  }
  
  //rounding
  for(int i=0;i<pixelLength;i++){
     
     int roundred = (_img.pixels[i] >> 16) & 0xFF; 
     roundred = roundred< 128 ? 0 : 255;
     int roundgreen = (_img.pixels[i] >> 8) & 0xFF;
     roundgreen = roundgreen < 128 ? 0 : 255;
     int roundblue = _img.pixels[i] & 0xFF; 
     roundblue = roundblue < 128 ? 0 : 255;

     _img.pixels[i] = color(roundred,roundgreen,roundblue);

  }
  
  _img.updatePixels();
  return _img;
    
}

PImage jarvis (PImage r, int mode){
  
  int [] j_loc = new int [12];
  PImage _img = new PImage(r.width, r.height, ARGB);
  float diffred = 0.0;
  float diffgreen = 0.0;
  float diffblue = 0.0;
  float diff = 0.0;
  _img.copy(r,0,0,imgWidth,imgHeight,0,0,imgWidth,imgHeight);
  _img.loadPixels();

  
  
  for (int x = 0; x < imgWidth; x++) {
    for (int y = 0; y < imgHeight; y++) {
      
      int loc1 = x+y*imgWidth;//origin
      
      if(mode==1){//color
        
        float ored = (_img.pixels[loc1] >> 16) & 0xFF; //fast red
        float ogreen = (_img.pixels[loc1] >> 8) & 0xFF; //fast green
        float oblue = _img.pixels[loc1] & 0xFF;//fast blue
        
        float nred = ored<128 ? 0 : 255;
        float nblue = oblue<128 ? 0 : 255;
        float ngreen = ogreen<128 ? 0 : 255;
        
        diffred = ored - nred;
        diffgreen = ogreen - ngreen;
        diffblue = oblue - nblue;

        _img.pixels[loc1] = color(nred,ngreen,nblue);
     
      }else{//b&w
      
        float obright = brightness(_img.pixels[loc1]);
        float nbright = obright<128 ? 0 : 255;
        diff = obright-nbright;
      
        _img.pixels[loc1] = color(nbright);
      }
      
      //jjn locations
      j_loc[0] = loc1+1;
      j_loc[1] = loc1+2;
      j_loc[2] = (loc1+imgWidth)-2;
      j_loc[3] = j_loc[2]+1;
      j_loc[4] = loc1+imgWidth;
      j_loc[5] = j_loc[4]+1;
      j_loc[6] = j_loc[5]+1;
      j_loc[7] = j_loc[2]+imgWidth;
      j_loc[8] = j_loc[7]+1;
      j_loc[9] = loc1+(imgWidth*2);
      j_loc[10] = j_loc[9]+1;
      j_loc[11] = j_loc[10]+1;
      
      for(int i=0; i<j_loc.length; i++){
       if(j_loc[i] < pixelLength){
         
         color fs;
         float jw = 0.0;
         
         if(i==0||i==4){
          jw=7.0/48; 
         }else if(i==1||i==3||i==5||i==9){
           jw=5.0/48;
         }else if(i==2||i==6||i==8||i==10){
           jw=3.0/48;
         }else if(i==7||i==11){
           jw = 1.0/48;
         }
         
         if(mode==1){//color
           fs = color(((_img.pixels[j_loc[i]] >> 16) & 0xFF)+jw * diffred, 
                   ((_img.pixels[j_loc[i]] >> 8) & 0xFF)+jw * diffgreen, 
                   (_img.pixels[j_loc[i]] & 0xFF)+jw * diffblue);
         }else{//b&w
           fs = color(brightness(_img.pixels[j_loc[i]])+jw * diff);
         }
          
         _img.pixels[j_loc[i]] = fs; 
          
       } 
      }
 
    }
  }
  
  for(int i=0;i<pixelLength;i++){
     
     int roundred = (_img.pixels[i] >> 16) & 0xFF; 
     roundred = roundred< 128 ? 0 : 255;
     int roundgreen = (_img.pixels[i] >> 8) & 0xFF;
     roundgreen = roundgreen < 128 ? 0 : 255;
     int roundblue = _img.pixels[i] & 0xFF; 
     roundblue = roundblue < 128 ? 0 : 255;

     _img.pixels[i] = color(roundred,roundgreen,roundblue);

  }
  
  _img.updatePixels();
  return _img;
    
}

PImage stucki (PImage r, int mode){
  
  int [] j_loc = new int [12];
  PImage _img = new PImage(r.width, r.height, ARGB);
  float diffred = 0.0;
  float diffgreen = 0.0;
  float diffblue = 0.0;
  float diff = 0.0;
  _img.copy(r,0,0,imgWidth,imgHeight,0,0,imgWidth,imgHeight);
  _img.loadPixels();

  
  
  for (int x = 0; x < imgWidth; x++) {
    for (int y = 0; y < imgHeight; y++) {
      
      int loc1 = x+y*imgWidth;//origin
      
      if(mode==1){//color
        
        float ored = (_img.pixels[loc1] >> 16) & 0xFF; //fast red
        float ogreen = (_img.pixels[loc1] >> 8) & 0xFF; //fast green
        float oblue = _img.pixels[loc1] & 0xFF;//fast blue
        
        float nred = ored<128 ? 0 : 255;
        float nblue = oblue<128 ? 0 : 255;
        float ngreen = ogreen<128 ? 0 : 255;
        
        diffred = ored - nred;
        diffgreen = ogreen - ngreen;
        diffblue = oblue - nblue;

        _img.pixels[loc1] = color(nred,ngreen,nblue);
     
      }else{//b&w
      
        float obright = brightness(_img.pixels[loc1]);
        float nbright = obright<128 ? 0 : 255;
        diff = obright-nbright;
      
        _img.pixels[loc1] = color(nbright);
      }
      
      //jjn locations
      j_loc[0] = loc1+1;
      j_loc[1] = loc1+2;
      j_loc[2] = (loc1+imgWidth)-2;
      j_loc[3] = j_loc[2]+1;
      j_loc[4] = loc1+imgWidth;
      j_loc[5] = j_loc[4]+1;
      j_loc[6] = j_loc[5]+1;
      j_loc[7] = j_loc[2]+imgWidth;
      j_loc[8] = j_loc[7]+1;
      j_loc[9] = loc1+(imgWidth*2);
      j_loc[10] = j_loc[9]+1;
      j_loc[11] = j_loc[10]+1;
      
      for(int i=0; i<j_loc.length; i++){
       if(j_loc[i] < pixelLength){
         
         color fs;
         float sw =0.0;
         
          if(i==0){
          sw = 7.0/42; 
         }else if(i==1){
           sw = 5.0/42;
         }else if(i==2||i==6||i==8||i==10){
           sw = 2.0/42; 
         }else if(i==3||i==5||i==9){
           sw = 4.0/42; 
         }else if(i==4){
           sw = 8.0/42; 
         }else if(i==7||i==11){
           sw = 1.0/42;
         }
         
         if(mode==1){//color
           fs = color(((_img.pixels[j_loc[i]] >> 16) & 0xFF)+sw * diffred, 
                   ((_img.pixels[j_loc[i]] >> 8) & 0xFF)+sw * diffgreen, 
                   (_img.pixels[j_loc[i]] & 0xFF)+sw * diffblue);
         }else{//b&w
           fs = color(brightness(_img.pixels[j_loc[i]])+sw * diff);
         }
          
         _img.pixels[j_loc[i]] = fs; 
          
       } 
      }
 
    }
  }
  
  for(int i=0;i<pixelLength;i++){
     
     int roundred = (_img.pixels[i] >> 16) & 0xFF; 
     roundred = roundred< 128 ? 0 : 255;
     int roundgreen = (_img.pixels[i] >> 8) & 0xFF;
     roundgreen = roundgreen < 128 ? 0 : 255;
     int roundblue = _img.pixels[i] & 0xFF; 
     roundblue = roundblue < 128 ? 0 : 255;

     _img.pixels[i] = color(roundred,roundgreen,roundblue);

  }
  
  _img.updatePixels();
  return _img;
    
}

PImage clustered(PImage r, int mode){
  
   int newred;
   int newgreen;
   int newblue;
   
   PImage _img = new PImage(r.width, r.height, ARGB);
   _img.copy(r,0,0,imgWidth,imgHeight,0,0,imgWidth,imgHeight);
   _img.loadPixels();

   
   float [] d = {0.7500, 0.3750, 0.6250, 0.2500, 0.0625, 1.0000, 0.8750, 0.4375,
      0.5000, 0.8125, 0.9375, 0.1250, 0.1875, 0.5625, 0.3125, 0.6875 };
      
   for(int i=0; i<d.length; i++){
      d[i] *= 255;
   }   
     
  for(int x=0;x<imgWidth; x++){
    for(int y=0;y<imgHeight; y++){
      
      if(mode==1){
         
         float ored = (_img.pixels[x+y*imgWidth] >> 16) & 0xFF; 
         if( ored >= d[ ( y%4 * 4 + x%4) ]){
           newred = 255;
         }else{
           newred = 0; 
         }
         
         float ogreen = (_img.pixels[x+y*imgWidth] >> 8) & 0xFF;
         if(ogreen >= d[ ( y%4 * 4 + x%4) ]){
           newgreen = 255;
         }else{
           newgreen = 0; 
         }
         
         float oblue = _img.pixels[x+y*imgWidth] & 0xFF; 
         if(oblue >= d[ ( y%4 * 4 + x%4) ]){
           newblue = 255;
         }else{
           newblue = 0; 
         }
         
         _img.pixels[x+y*imgWidth] = color(newred, newgreen, newblue);
     
      }else{
        
        if(brightness(_img.pixels[x+y*imgWidth]) >= d[ ( y%4 * 4 + x%4) ]){
           newblue = 255;
         }else{
           newblue = 0; 
         }
     
         _img.pixels[x+y*imgWidth] = color(newblue);
        
      }
      
    }
   }
  
   for(int i=0;i<pixelLength;i++){
     
     int roundred = (_img.pixels[i] >> 16) & 0xFF; 
     roundred = roundred< 128 ? 0 : 255;
     int roundgreen = (_img.pixels[i] >> 8) & 0xFF;
     roundgreen = roundgreen < 128 ? 0 : 255;
     int roundblue = _img.pixels[i] & 0xFF; 
     roundblue = roundblue < 128 ? 0 : 255;

     _img.pixels[i] = color(roundred,roundgreen,roundblue);

  }
  
  _img.updatePixels();
  return _img;
  
}

PImage bayer2(PImage r, int mode){
  
   int newred;
   int newgreen;
   int newblue;
   
   PImage _img = new PImage(r.width, r.height, ARGB);
   _img.copy(r,0,0,imgWidth,imgHeight,0,0,imgWidth,imgHeight);
   _img.loadPixels();

   
   float [] d = {2,3,4,1};
      
   for(int i=0; i<d.length; i++){
      d[i] = d[i]*64 -1;
   }   
     
  for(int x=0;x<imgWidth; x++){
    for(int y=0;y<imgHeight; y++){
      
      if(mode==1){
     
         float ored = (_img.pixels[x+y*imgWidth] >> 16) & 0xFF; 
         if( ored >= d[(y%2*2+x%2)]){
           newred = 255;
         }else{
           newred = 0; 
         }
         
         float ogreen = (_img.pixels[x+y*imgWidth] >> 8) & 0xFF;
         if(ogreen >= d[(y%2*2+x%2)]){
           newgreen = 255;
         }else{
           newgreen = 0; 
         }
         
         float oblue = _img.pixels[x+y*imgWidth] & 0xFF; 
         if(oblue >= d[(y%2*2+x%2)]){
           newblue = 255;
         }else{
           newblue = 0; 
         }
         
         _img.pixels[x+y*imgWidth] = color(newred, newgreen, newblue);
     
      }else{
        
        if(brightness(_img.pixels[x+y*imgWidth]) >= d[(y%2*2+x%2)]){
           newblue = 255;
         }else{
           newblue = 0; 
         }
     
         _img.pixels[x+y*imgWidth] = color(newblue);
        
      }
      
    }
   }
  
   for(int i=0;i<pixelLength;i++){
     
     int roundred = (_img.pixels[i] >> 16) & 0xFF; 
     roundred = roundred< 128 ? 0 : 255;
     int roundgreen = (_img.pixels[i] >> 8) & 0xFF;
     roundgreen = roundgreen < 128 ? 0 : 255;
     int roundblue = _img.pixels[i] & 0xFF; 
     roundblue = roundblue < 128 ? 0 : 255;

     _img.pixels[i] = color(roundred,roundgreen,roundblue);

  }
  
  _img.updatePixels();
  return _img;
  
}

PImage bayer4(PImage r, int mode){
  
   int newred;
   int newgreen;
   int newblue;
   
   PImage _img = new PImage(r.width, r.height, ARGB);
   _img.copy(r,0,0,imgWidth,imgHeight,0,0,imgWidth,imgHeight);
   _img.loadPixels();

   
   float [] d = {0.1250, 1.0000, 0.1875, 0.8125, 0.6250, 0.3750, 0.6875,
     0.4375,0.2500, 0.8750, 0.0625, 0.9375, 0.7500, 0.5000, 0.5625, 0.3125};
      
   for(int i=0; i<d.length; i++){
      d[i] *= 255;
   }   
     
  for(int x=0;x<imgWidth; x++){
    for(int y=0;y<imgHeight; y++){
    
      if(mode==1){
     
         float ored = (_img.pixels[x+y*imgWidth] >> 16) & 0xFF; 
         if( ored >= d[(y%4*4+x%4)]){
           newred = 255;
         }else{
           newred = 0; 
         }
         
         float ogreen = (_img.pixels[x+y*imgWidth] >> 8) & 0xFF;
         if(ogreen >= d[(y%4*4+x%4)]){
           newgreen = 255;
         }else{
           newgreen = 0; 
         }
         
         float oblue = _img.pixels[x+y*imgWidth] & 0xFF; 
         if(oblue >= d[(y%4*4+x%4)]){
           newblue = 255;
         }else{
           newblue = 0; 
         }
         
         _img.pixels[x+y*imgWidth] = color(newred, newgreen, newblue);
     
      }else{
        
        if(brightness(_img.pixels[x+y*imgWidth]) >= d[(y%4*4+x%4)]){
           newblue = 255;
         }else{
           newblue = 0; 
         }
     
         _img.pixels[x+y*imgWidth] = color(newblue);
        
      }
      
    }
   }
  
   for(int i=0;i<pixelLength;i++){
     
     int roundred = (_img.pixels[i] >> 16) & 0xFF; 
     roundred = roundred< 128 ? 0 : 255;
     int roundgreen = (_img.pixels[i] >> 8) & 0xFF;
     roundgreen = roundgreen < 128 ? 0 : 255;
     int roundblue = _img.pixels[i] & 0xFF; 
     roundblue = roundblue < 128 ? 0 : 255;

     _img.pixels[i] = color(roundred,roundgreen,roundblue);

  }
  
  _img.updatePixels();
  return _img;
  
}

PImage bayer8(PImage r, int mode){
  
   int newred;
   int newgreen;
   int newblue;
   
   PImage _img = new PImage(r.width, r.height, ARGB);
   _img.copy(r,0,0,imgWidth,imgHeight,0,0,imgWidth,imgHeight);
   _img.loadPixels();

   
   float [] d = {1, 33,  9, 41, 3,  35, 11, 43, 49, 17, 57, 25, 51, 19, 59, 27, 13, 45, 5, 
    37, 15, 47, 7, 39, 61, 29, 53, 21, 63, 31, 55, 23, 4, 36, 12, 44, 2, 34, 10, 42, 52,
    20, 60, 28, 50, 18, 58, 26, 16, 48, 8, 40, 14, 46, 6, 38, 64, 32, 56, 24, 62, 30,
    54, 22};
      
   for(int i=0; i<d.length; i++){
      d[i] = d[i]*4-1;
   }   
     
  for(int x=0;x<imgWidth; x++){
    for(int y=0;y<imgHeight; y++){
      
      if(mode==1){
     
         float ored = (_img.pixels[x+y*imgWidth] >> 16) & 0xFF; 
         if( ored >= d[(y%8*8+x%8)]){
           newred = 255;
         }else{
           newred = 0; 
         }
         
         float ogreen = (_img.pixels[x+y*imgWidth] >> 8) & 0xFF;
         if(ogreen >= d[(y%8*8+x%8)]){
           newgreen = 255;
         }else{
           newgreen = 0; 
         }
         
         float oblue = _img.pixels[x+y*imgWidth] & 0xFF; 
         if(oblue >= d[(y%8*8+x%8)]){
           newblue = 255;
         }else{
           newblue = 0; 
         }
         
         _img.pixels[x+y*imgWidth] = color(newred, newgreen, newblue);
     
      }else{
        
        if(brightness(_img.pixels[x+y*imgWidth]) >= d[(y%8*8+x%8)]){
           newblue = 255;
         }else{
           newblue = 0; 
         }
     
         _img.pixels[x+y*imgWidth] = color(newblue);
        
      }
      
    }
   }
  
   for(int i=0;i<pixelLength;i++){
     
     int roundred = (_img.pixels[i] >> 16) & 0xFF; 
     roundred = roundred< 128 ? 0 : 255;
     int roundgreen = (_img.pixels[i] >> 8) & 0xFF;
     roundgreen = roundgreen < 128 ? 0 : 255;
     int roundblue = _img.pixels[i] & 0xFF; 
     roundblue = roundblue < 128 ? 0 : 255;

     _img.pixels[i] = color(roundred,roundgreen,roundblue);

  }
  
  _img.updatePixels();
  return _img;
  
}

PImage randomPattern(PImage r, int mode){
  
   int newred;
   int newgreen;
   int newblue;
   
   
   PImage _img = new PImage(r.width, r.height, ARGB);
   _img.copy(r,0,0,imgWidth,imgHeight,0,0,imgWidth,imgHeight);
   _img.loadPixels();

   
   for(int x=0;x<imgWidth; x++){
    for(int y=0;y<imgHeight; y++){
      
      float rand = random(256);
      
      if(mode==1){
     
         float ored = (_img.pixels[x+y*imgWidth] >> 16) & 0xFF; 
         if( ored >= rand){
           newred = 255;
         }else{
           newred = 0; 
         }
         
         float ogreen = (_img.pixels[x+y*imgWidth] >> 8) & 0xFF;
         if(ogreen >= rand){
           newgreen = 255;
         }else{
           newgreen = 0; 
         }
         
         float oblue = _img.pixels[x+y*imgWidth] & 0xFF; 
         if(oblue >= rand){
           newblue = 255;
         }else{
           newblue = 0; 
         }
         
         _img.pixels[x+y*imgWidth] = color(newred, newgreen, newblue);
     
      }else{
        
        if(brightness(_img.pixels[x+y*imgWidth]) >= rand){
           newblue = 255;
         }else{
           newblue = 0; 
         }
     
         _img.pixels[x+y*imgWidth] = color(newblue);
        
      }
      
    }
   }
  
   for(int i=0;i<pixelLength;i++){
     
     int roundred = (_img.pixels[i] >> 16) & 0xFF; 
     roundred = roundred< 128 ? 0 : 255;
     int roundgreen = (_img.pixels[i] >> 8) & 0xFF;
     roundgreen = roundgreen < 128 ? 0 : 255;
     int roundblue = _img.pixels[i] & 0xFF; 
     roundblue = roundblue < 128 ? 0 : 255;

     _img.pixels[i] = color(roundred,roundgreen,roundblue);

  }
  
  _img.updatePixels();
  return _img;
   
  
}
