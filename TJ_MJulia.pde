//vectors needed
PVector c1, c2, z, cMap, c, p, mousein, fragCoord, fragColor, iResolution;

void setup() {
  size(800, 600, P2D);
  noStroke();
  
  colorMode(RGB, 1.0);
}  

void draw() {
for (int x = 0; x < width; x++) 
     for (int y = 0; y < height; y++)
          mainImage((float)x,(float)y);
  
}  


//z starts with an initial value of the pixel(c1) and then you 
//add c2 in the iteration which can 
//be a constant or mouse position


float fJulia(PVector c1, PVector c2){
  int MAX_ITER = 1000;  
  float l = 0.;
    PVector z = c1;
    float B = 256.;
    for(float i=0.;i<float(MAX_ITER);i++) {
        if (z.x*z.x + z.y*z.y > 4.) {
          return l;
           
        }
        float xtemp = z.x*z.x-(z.y*z.y);
        z.y = 2.*z.x*z.y + c2.y;
        z.x = xtemp + c2.x;
        l+=1.;
    }
    float sl = l - log(log((String.valueOf(z.x).length()))/log(B))/log(2.0);
    return sl;
    //return l;
}

PVector trueCmap(float n)  {  
    int MAX_ITER = 1000;
    if (n == float(MAX_ITER)){
        PVector black = new PVector(0.,0.,0.); 
        return black;
    }
    PVector cMap[] = {new PVector(0.,0.,0.), new PVector(1.,0.,1.), new PVector(0.,0.,1.), new PVector(0.,1.,0.), new PVector(1.,1.,0.), new PVector(1.,0.5,0.), new PVector(0.,0.,0.)};
    float quotient = float(7) * n / float(MAX_ITER);
    float lowerIndex = floor(quotient);
    float upperIndex = ceil(quotient);
    int lIndex = int(lowerIndex);
    int uIndex = int(upperIndex);
    float fraction = quotient - lowerIndex;
    PVector fracVector = new PVector(int(fraction), int(fraction));
     c = new PVector((cMap[lIndex].add(fracVector)).dot((cMap[uIndex].sub(cMap[lIndex]))),(cMap[lIndex].add(fracVector)).dot((cMap[uIndex].sub(cMap[lIndex]))),(cMap[lIndex].add(fracVector)).dot((cMap[uIndex].sub(cMap[lIndex]))));
    
return c;
}

void mainImage(float x,float  y) {
    fragCoord = new PVector(x,y);
    PVector iResolution = new PVector(width, height);
    PVector iMouse = new PVector(mouseX,mouseY);
    PVector stepa = new PVector(fragCoord.dot(2.,2.,2.),fragCoord.dot(2.,2.,2.),fragCoord.dot(2.,2.,2.));
    PVector p =  (stepa.sub(iResolution).div(iResolution.x));
    PVector mousein = new PVector(iMouse.dot(2.,2.,2.),iMouse.dot(2.,2.,2.),iMouse.dot(2.,2.,2.)).sub(iResolution).div(iResolution.x);
    p = p.mult(2.);
    float iCount = fJulia(p, mousein);
    point(x,y);
    fragColor = trueCmap(iCount*2.);
    stroke(fragColor.x,fragColor.y,fragColor.z);
}
