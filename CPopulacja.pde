import java.util.Vector;

class CPopulacja
{
  Vector allLudzie,allObcy;
  int wiekRozrodczy;
  int maxIloscPotomkow;
  int szansaNaPotomka;
  int szansaNaPokonanieObcego;
  int aktualnaIloscLudzi;
  int aktualnaIloscObcych;
  int maxIloscLudzi;
  int maxIloscObcych;
  CKwadrat kwadrat;
  CQuadTree qt;
  int maxLiczbaPodzialow;
  
  CPopulacja()
  {
    allLudzie = new Vector();
    allObcy = new Vector();
    szansaNaPotomka=6;            // * 0,1%
    maxIloscPotomkow=2;
    wiekRozrodczy=13;
    maxIloscLudzi=1600;
    maxIloscObcych=1200;
    maxLiczbaPodzialow=6;        //max 6
    szansaNaPokonanieObcego=2;   //* 10%
  }
  
  void dodajCzlowieka(int x,int y, int wiek, int plec, Vector vec)
  {
    CCzlowiek temp= new CCzlowiek(x,y,wiek,plec);
    vec.addElement(temp);
  }
  
  void dodajObcego(int x,int y,int wiek,Vector vec)
  {
    CObcy temp = new CObcy(x,y,wiek);
    vec.addElement(temp);
  }
  
  void ruszajPopulacja()
  {
    for(int i=0;i<allLudzie.size();i++)
    {
      CCzlowiek temp=(CCzlowiek)allLudzie.elementAt(i);
      if(temp.wiek>temp.zywotnosc)
      {
        allLudzie.remove(i);
        i--;
      }else
      {
        temp.ruszaj();
        temp.rysuj();
      }
    }
    for(int i=0;i<allObcy.size();i++)
    {
      CObcy temp=(CObcy)allObcy.elementAt(i);
      if(temp.wiek>temp.zywotnosc)
      {
        allObcy.remove(i);
        i--;
      }else
      {
        temp.ruszaj();
        temp.rysuj();
      }
    }
    aktualnaIloscLudzi=this.allLudzie.size();
    aktualnaIloscObcych=this.allObcy.size();
  }
  
  void atakuj(Vector vecL,Vector vecO)
  {
    for(int i=0;i<vecL.size();i++)
    {
      CCzlowiek temp1=(CCzlowiek)vecL.elementAt(i);
      for(int j=0;j<vecO.size();j++)
      {
        CObcy temp2=(CObcy)vecO.elementAt(j);
        if(temp1.x==temp2.x && temp1.y==temp2.y)
        {
          int los=floor(random(10));
          if(los<this.szansaNaPokonanieObcego)
          {
            vecO.remove(j);
            j--;
            this.aktualnaIloscObcych--;
            continue;
          }else
          {
            vecL.remove(i);
            i--;
            this.aktualnaIloscLudzi--;
            break;
          }
        }
      }
    }
  }
  
  void rozmnazaj(Vector vecL,Vector vecO)
  {
    if(vecL.size()>1)
    {
      for(int i=0;i<vecL.size();i++)
      {
        CCzlowiek temp1=(CCzlowiek)vecL.elementAt(i);
        for(int j=i+1;j<vecL.size();j++)
        {
          CCzlowiek temp2=(CCzlowiek)vecL.elementAt(j);
          if(this.aktualnaIloscLudzi< maxIloscLudzi && temp1.x==temp2.x
          && temp1.y==temp2.y && temp1.plec!=temp2.plec
          && temp1.plodnosc>wiekRozrodczy && temp2.plodnosc>wiekRozrodczy)
          {
            this.aktualnaIloscLudzi++;
            dodajCzlowieka(temp1.x,temp1.y,0,1-2*floor(random(2)),vecL);
            temp1.plodnosc=0;
            temp2.plodnosc=0;
          }
        }
      }
    }
      
    for(int i=0;i<vecO.size();i++)
    {
      CObcy temp=(CObcy)vecO.elementAt(i);
      if(temp.iloscPotomkow<maxIloscPotomkow &&
        this.aktualnaIloscObcych<maxIloscObcych)
      {
        int los=floor(random(1000));
        if(los<szansaNaPotomka)
        {
          this.aktualnaIloscObcych--;
          dodajObcego(temp.x,temp.y,0,vecO);
          temp.iloscPotomkow++;
        }
      }
    }
  }
  
  void sortujPopulacje()
  {
    kwadrat= new CKwadrat(width/2,height/2,width/2,height/2);
    qt= new CQuadTree(kwadrat);
    for(int i=0;i<this.allLudzie.size();i++)
    {
      CCzlowiek temp=(CCzlowiek)allLudzie.elementAt(i);
      qt.dodaj(temp);
    }
    for(int i=0;i<this.allObcy.size();i++)
    {
      CObcy temp=(CObcy)allObcy.elementAt(i);
      qt.dodaj(temp);
    }
  }
}
