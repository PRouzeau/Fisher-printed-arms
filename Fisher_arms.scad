//Printed arms ends for RepRapPro Fisher delta printer
//Licence OSH V1.2 - (c)2015 Pierre ROUZEAU aka PRZ 
// see www.rouzeau.net/Print3D/FisherModifications for details
include <PRZutility.scad>

diamball = 5.97; // real ball diameter

//*
duply (12.5,5) { // display the ends
  tsl (48) rot (0,1.8) rodend();
  rot (0,1.8) rodend(false);
} //*/

module rodend(simple=true) {
  nutspace = 28; // position of the compression nut
  difference() {
    union(){
      hull() { // rod shape
        cylx (7, 30,  6+2.5,0,3.5);
         tsl (38.5,0,1.75)    
          rot (0,-1.8) cubex (-42,4.5,3.5);     
        if (!simple)
          rot (0,-1.8) cubez (6.5,9,7.5,   nutspace, 0,-1.23); 
      }
      hull() { // fork shape
        cyly (-9.5, 7.6, 0,0,3.5); 
        cylx (7,-1, 38.5,0,3.5);
        tsl (17,0,3.5)
          dmirrory() dmirrorz ()
            cylx (2.5,1, 0,3.5,3);
        tsl (38.5,0,1.75)    
          rot (0,-1.8) cubex (-42,6,3.5);       
      }
    } //::: Then whats removed :::
    tsl (38.5,0,0)    // bottom cut
      rot (0,-1.8) cubez (46,8,-2, -23);  
    cubez (24,2.3,12, 5,0,-2); //fork middle removal
    dmirrory() // sphere shaping
      tsl (0,0.6,3.5)
         difference () {
           sphere (d=diamball+0.22, $fn=60);   
           cubey (10,5,10);
         }   
    if (simple) // hole to screw in for simple end
      cylx (2.55, 30, 25,0,3.5);    
    else {
      cylx (3.1, 30, 19,0,3.5);  // shall not screw in
      cubez (3.9,5.45,66, nutspace, 0,-1); // nut hole
    }
    cyly(-4.15, 66, 0,0,3.5); // ball hole in fork
    cyly(-2.9, 66, 10,0,3.5); //side hole for fork pinch
  } //end diff
  if (!simple) // add compression cone after nut hole
    difference() {
      cconex (6.6,4.3,-1.25,-1, nutspace+1.95,0,3.5); 
      cylx (3.1, 30, 9,0,3.5);  
    }
}