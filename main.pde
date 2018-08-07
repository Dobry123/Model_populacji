CPopulacja populacja;
int iloscStartowaLudzi=1500;
int iloscStartowaObcych=600;

void setup()
{
  frameRate(120);
  size(512,512);
  populacja=new CPopulacja();
  for(int i=0;i<iloscStartowaLudzi;i++)
  {
    populacja.dodajCzlowieka((int)random(width),(int)random(height),0,1-2*floor(random(2)),populacja.allLudzie);
  }
  for(int i=0;i<iloscStartowaObcych;i++)
  {
    populacja.dodajObcego((int)random(width),(int)random(height),(int)random(100),populacja.allObcy);
  }
}

void draw()
{
  noStroke();
  fill(255,255,255,50);
  rectMode(CORNER);
  rect(0,0,width,height);
  
  populacja.ruszajPopulacja();
  populacja.sortujPopulacje();
  populacja.allLudzie = new Vector();
  populacja.allObcy = new Vector();
  populacja.qt.operacjeNaMalychCzesciach(populacja.allLudzie,populacja.allObcy);
  
  
  populacja.qt.rysujGranice();
  
  
  print("O:");
  print(populacja.allObcy.size());
  print(" || ");
  print("L:");
  print(populacja.allLudzie.size());
  print(" || ");
  print("FrameRate: ");
  println(frameRate);
}
