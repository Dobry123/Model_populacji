class CKwadrat
{
  int x,y;  //wspolrzedne srodka
  int s;    //szerokosc od srodka
  int w;    //wysokosc  od srodka
  CKwadrat(int x,int y,int s, int w)
  {
    this.x=x;
    this.y=y;
    this.s=s;
    this.w=w;
  }
  boolean zawieraOsobnika(int a,int b)
  {
    if(a>=this.x-this.s && a<=this.x+this.s && b>=this.y-this.w && b<=this.y+this.w)
      return true;
    else
      return false;
  }
}
