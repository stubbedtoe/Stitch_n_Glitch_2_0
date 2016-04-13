![lena](http://www.stitch-n-glitch.com/version2/images/bg3.gif)

# Stitch'n'Glitch
## by Andrew Healy (http://www.stitch-n-glitch.com/version2) 2012 (version 2.0 2013) contact: [werdnah19@gmail.com](mailto:werdnah19@gmail.com)

### OVERVIEW:

This program was intended as a combined image-corruption and cross-stitch pattern generator. Along the way some other functionalities were added but it remains a simple, small application to preform this very specific task. There are other, more powerful cross-stitch pattern generators available both online and off as well as various image-corruption facilities. This application was never intended as the fastest, most powerful or fullest-featured pattern generator - rather a product of my personal artistic exploration into the aesthetic possibilities of mixing the electronic "glitched" image with a hand-crafted cross-stitch.

This is an open-source project in appreciation of textile art's history of sharing techniques and patterns. Feel free to modify for your own use in keeping with the same spirit.

This document just covers the basics. For some useful tips & tricks, pretty images etc., visit the [project site](http://www.stitch-n-glitch.com/version2).

#### INSTALLATION:
Windows and Linux Users should make sure Java is installed on their computer. Mac users can check if their Java is up to date by requesting a software update check. Windows and Linux users should keep the `lib`,`data`, and `source` folders in the same folder as the actual application file.

If compiling from the Processing IDE, please use at least Processing 2.0 due to important changes. Also note *Stitch'n'Glitch* requires a couple of libraries to function. Links are at the bottom of this document.

### USING THE SOFTWARE

1. #### Choose an image

 On launching the application, you will be asked to choose an image file through your system's file interface. *Stitch'n'Glitch* can process .jpg(RGB) or .gif files and it is recommended to keep images < 1mB / 1,500,000 pixels to avoid slowness (that said, *Stitch'n'Glitch 2.0* is a lot better than its predecessor at handling large files).

 If you choose a different type of file you will be asked for another.
 The message bar (closed by default but opened by clicking the yellow panel or pressing 'm') shows the size of image, file name and it it is a suitable image for stitching and/or glitching.

2. #### Glitch

 Before you can export the image (for stitching or anything else) you must go through the 'glitch' process.

 ![dither types](http://www.stitch-n-glitch.com/version2/images/art/full/ditherCol.gif)

 * On the `Glitch` panel you can adjust the `glitch amount` (__0 for no glitch__), if the image is dithered before glitching (and the [dither type](https://en.wikipedia.org/wiki/Dither#Algorithms): `Atkinson`, `Jarvis-Judice-Ninke`, `Stucki`, `Clustered 4x4`, `Bayer` (`2x2`, `4x4`, `8x8`) and `random`; `1-bit` and `3-bit`), and if the image is dithered after glitching. `No dither` is the default before glitching, `Atkinson 3-bit` for after. The default `Glitch amount` is `10` (although this is far too high for some small images).

 __Users are encouraged to experiment with the different algorithms and their combinations.__

 If `No Dither` is selected for after the glitch, The user has the option to reduce colors in the final image for the pattern (a maximum value of `50` will return the most amount of colours that are in the image that are also in the DMC-brand palette of stranded cotton. Bear in mind that this is up to 446 colors and could be a pain to cross-stitch).

 If you are using a large file (see the tip at the bottom) or are dithering after glitching, this option isn't available.

 * Press `Glitch` when you are ready. The activity bar will start and the message will give verbal feedback on the application's progress. For the first glitch of the session, the application will wait until this process is complete before displaying the image on the right. For every glitch after, however, the pixels will be updated and displayed in synch.

 * If you have been sucessful, the number of DMC colours and size of finished cross stitch (on 14ct fabric) are displayed in the message bar. If the image breaks during glitching, a  message will be displayed over the image on the right and the message bar will read *Image is broken*. You could reduce the glitch amount or try again - sometimes the same glitch amount will break an image when usually it wouldn't … enjoy the random process.

3. #### Export

 *Stitch'n'Glitch* has many new export options.

 The user can now choose to export not just the most recently glitches image but the previous three (sucessful) glitches. Having this choice is intended to reduce the 'panic-exporting' of the previous version. You can make this choice by clicking the image on the right, the indicator squares at the top of the panel, or by using the numbers '1-4' on the keyboard.

 Export options available for all successfully glitches images:

 - `.csv` file for data visualization (this is a file containing each pixel's  hexadecimal colour value - for loading back into *Processing* or similar).

 - `.pdf` vector image (a vector file of the image for large-scale printing, editing in *Illustrator* etc,.).

 - `.tiff` bitmap image (a simple lossless image file of the glitch).

 Export options available for all glitched files under the size threshold (by default <90kB or 200,000 pixels):

 - single page black + white pattern (This is the same file as the first version: a large, single page .pdf with fixed symbols for each colour).

 - multi page black + white pattern (Suitable for printing on your home printer - this file also contains a page showing how the image has been divided into pages for the pattern. Pages run left to right and top to bottom).

 Export options available for glitches files under the size threshold and with 80 colours or less:

 - single page simplified colour pattern

 - multi page simplified colour pattern

 The simplified patterns use dynamically assigned symbols to make each distinct from the last. The symbols are easy to read and use 4 contrasting colors. They are made up of 20 symbols repeated a maximum of 4 times (one for each symbol in each colour) so for this reason, they really should be printed in colour.

 On rare occasions when exporting a simplified colour pattern a couple of colours may be missing. There will be a warning in the message bar if this is the case. If you want to find out which colours they are, export a B & W pattern of the same image and cross-check. Or you can just replace these pixels with whatever colour thread you like (Yay DIY glitch!).

 __ALL PATTERNS ARE EXPORTED WITH A CORRESPONDING LIST OF SYMBOLS, DMC CODES AND NUMBER OF STITCHES OF EACH IN THE PATTERN.__

 When you have made your choice, press `Export`. If this is your first export of the session, you will be asked to choose a location to save exported files. All files from the session will be exported to this location. The message bar will display this location along with the unique time-stamp for this export. The activity bar will start and the message bar will update progress. Be patient - large patterns can take a long time to export.

### TIP FOR USING LARGE IMAGES

The maximum size of image (in bytes or number of pixels) that a pattern can be made from is altered by editing the preferences.txt file. This file can be found: (On Mac) by right-clicking the `.app` file -> __Show Package Contents__ -> __Contents__ -> __Resources__ -> __Java__ -> __data__. For Windows, the `data` folder should be in the same directory as the `.exe`.

Raise one or both of the figures to try to create very large cross-stitch files (not recommended - may crash the application) or lower the figures if you are more interested in glitching/dithering without converting to the DMC palette.

### ACKNOWLEDGEMENTS

- Coded 2012 (revised 2013) by Andrew Healy ([andrewhealy.com](http://www.andrewhealy.com))
- Built with [Processing](http://processing.org) using the [Toxi](http://toxiclibs.org) Color Utilities libraries for colour-management and the [controlP5](http://sojamo.de/libraries/controlP5/) library for GUI components.
- Image-corruption code adapted from the *Corrupt* project by [Benjamin Gaulon](http://recyclism.com).
- DMC floss to RGB/HEX conversion from a document at http://www.radicalcrossstitch.com/DMCFloss-RGBvalues.html
- Dithering algorithms ported to *Processing* from the Macro code found at http://fiji.sc/wiki/index.php/Dithering
- Many thanks to the Processing community for sharing their knowledge.
- Project inspired by the *Lost Threads* research project and [blog](http://lost threads.tumblr.com)
