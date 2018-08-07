import java.util.Vector;

class CQuadTree
{
  CKwadrat granica;
  boolean podzielony;
  Vector Ludzie,Obcy;
  CQuadTree polnocnyWschod;
  CQuadTree poludniowyWschod;
  CQuadTree polnocnyZachod;
  CQuadTree poludniowyZachod;
  
  CQuadTree(CKwadrat granica)
  {
    this.Ludzie = new Vector();
    this.Obcy = new Vector();
    this.granica=granica;
    this.podzielony=false;
  }
  
  void podziel()
  {
    int x=this.granica.x;
    int y=this.granica.y;
    int s=floor(this.granica.s / 2);
    int w=floor(this.granica.w / 2);
    CKwadrat ne = new CKwadrat(x + s, y - w, s, w);
    this.polnocnyWschod = new CQuadTree(ne);
    CKwadrat nw = new CKwadrat(x - s, y - w, s, w);
    this.polnocnyZachod = new CQuadTree(nw);
    CKwadrat se = new CKwadrat(x + s, y + w, s, w);
    this.poludniowyWschod = new CQuadTree(se);
    CKwadrat sw = new CKwadrat(x - s, y + w, s, w);
    this.poludniowyZachod = new CQuadTree(sw);
    this.podzielony=true;
  }
  
  boolean dodaj(CCzlowiek czlowiek)
  {
    if(!this.granica.zawieraOsobnika(czlowiek.x,czlowiek.y))
      return false;
      
    int iloscPodzialow=floor(width/2/2/this.granica.s);
    switch(iloscPodzialow)
    {
      case 4:
        iloscPodzialow=3;
        break;
      case 8:
        iloscPodzialow=4;
        break;
      case 16:
        iloscPodzialow=5;
        break;
      case 32:
        iloscPodzialow=6;
        break;
      default:
        break;
    }
    if(iloscPodzialow<populacja.maxLiczbaPodzialow)
    {    
      if(!podzielony)
      {
        this.podziel();
      }
      return(this.polnocnyWschod.dodaj(czlowiek) || this.polnocnyZachod.dodaj(czlowiek)
      || this.poludniowyWschod.dodaj(czlowiek) || this.poludniowyZachod.dodaj(czlowiek));
    }
    else
    {
      this.Ludzie.addElement(czlowiek);
      return true;
    }
  }
  
  boolean dodaj(CObcy obcy)
  {
    if(!this.granica.zawieraOsobnika(obcy.x,obcy.y))
      return false;
      
    int iloscPodzialow=floor(width/2/2/this.granica.s);
    switch(iloscPodzialow)
    {
      case 4:
        iloscPodzialow=3;
        break;
      case 8:
        iloscPodzialow=4;
        break;
      case 16:
        iloscPodzialow=5;
        break;
      case 32:
        iloscPodzialow=6;
        break;
      default:
        break;
    }
    if(iloscPodzialow<populacja.maxLiczbaPodzialow)
    {  
      if(!podzielony)
      {
        this.podziel();
      }
      
      return(this.polnocnyWschod.dodaj(obcy) || this.polnocnyZachod.dodaj(obcy)
      || this.poludniowyWschod.dodaj(obcy) || this.poludniowyZachod.dodaj(obcy));
    }
    else
    {
      this.Obcy.addElement(obcy);
      return true;
    }
  }
  void rysujGranice()
  {
    stroke(0);
    noFill();
    rectMode(CENTER);
    rect(this.granica.x,this.granica.y,this.granica.s*2,this.granica.w*2);
    if(this.podzielony)
    {
      this.polnocnyWschod.rysujGranice();
      this.poludniowyWschod.rysujGranice();
      this.polnocnyZachod.rysujGranice();
      this.poludniowyZachod.rysujGranice();
    }
  }
  
  int operacjeNaMalychCzesciach(Vector updateVecL, Vector updateVecO)
  {
    if(this.podzielony)
    {
      this.polnocnyWschod.operacjeNaMalychCzesciach(updateVecL,updateVecO);
      this.poludniowyWschod.operacjeNaMalychCzesciach(updateVecL,updateVecO);
      this.polnocnyZachod.operacjeNaMalychCzesciach(updateVecL,updateVecO);
      this.poludniowyZachod.operacjeNaMalychCzesciach(updateVecL,updateVecO);
    }
    else
    {
      populacja.atakuj(this.Ludzie,this.Obcy);
      populacja.rozmnazaj(this.Ludzie,this.Obcy);
      for(int i=0;i<this.Ludzie.size();i++)
        updateVecL.addElement(this.Ludzie.elementAt(i));
      for(int i=0;i<this.Obcy.size();i++)
        updateVecO.addElement(this.Obcy.elementAt(i));
      return 1;
    }
    return 1;
  }
}
