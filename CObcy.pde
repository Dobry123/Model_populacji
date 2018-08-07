class CObcy extends CCzlowiek
{
  public
  int iloscPotomkow;
  int dir;
  int szansaNaWykrycieCzlowieka;
  CObcy(int x, int y, int wiek)
  {
    super(x,y,wiek,0);
    iloscPotomkow=0;
    szansaNaWykrycieCzlowieka = 2;  // *10%
  }
  
  void rysuj()
  {
    stroke(0,153,0);
    point(x,y);
  }
  
  void ruszaj()
  {
    int los=floor(random(10));
    if(los<this.szansaNaWykrycieCzlowieka && populacja.allLudzie.size()!=0)
    {
      CCzlowiek temp=(CCzlowiek)populacja.allLudzie.elementAt(0);
      int xDystans=temp.x-this.x;
      int yDystans=temp.y-this.y;
      if(abs(xDystans)>abs(yDystans))
      {
        if(xDystans>0)
          dir=1;
        else
          dir=0;
      }else if(yDystans>0)
          dir=3;
       else
           dir=2;
    }
    else
      dir=floor(random(4));
    switch(dir)
    {
      case 0:
        if(x>1)
          x-=2;
        break;
      case 1:
        if(x<width-1)
        x+=2;
        break;
      case 2:
        if(y>1)
          y-=2;
          break;
       case 3:
         if(y<height-1)
         y+=2;
         break;
    }
    wiek++;
    plodnosc++;
  }
}
