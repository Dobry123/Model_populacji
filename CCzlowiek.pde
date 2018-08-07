class CCzlowiek
{
  public
  int x,y;
  int wiek;
  int zywotnosc;
  int plec;
  int plodnosc;
  
  CCzlowiek(int x, int y, int wiek, int plec)
  {
    this.x=x;
    this.y=y;
    this.wiek=wiek;
    this.plec=plec;
    zywotnosc=300+(int)random(50);
    plodnosc=0;
  }
  
    void ruszaj()
  {
    int r=floor(random(4));
    switch(r)
    {
      case 0:
        if(x>0)
          x--;
        break;
      case 1:
        if(x<width)
        x++;
        break;
      case 2:
        if(y>0)
          y--;
          break;
       case 3:
         if(y<height)
         y++;
         break;
    }
    wiek++;
    plodnosc++;
  }
  
  void rysuj()
  {
    if(plec==1)  stroke(255,0,0);
    if(plec==-1)  stroke(0,0,255);
    point(x,y);
  }
}
