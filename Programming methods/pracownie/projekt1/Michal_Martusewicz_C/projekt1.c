#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include "zolw.h"
/*
 Opis działania programu:
 Zeby nie zwariowac, zamiast punktu wyobrazam sobie zolwia ktory chodzi w przestrzeni.
 Zolw ma dane dwa kierunki: ten na ktory wskazuje jego pysk i plecy.
 Do tego mam funkcje ktora definiuje prawa strone zolwia w zaleznosci od polozenia plecow i pysku zolwia.
 Ponadto uzywam funkcji rev, ktora podaje kierunek odwrotny do podanego (jest szesc kieronkow: North, South, East, West, Up, Down).

 Wyobrazony zolw najpierw obraca sie odpowiednio, potem wykonuje krzywa hilberta nizszego rzedu
 (ktora- to wazne!- nie zmienia kierunku ustawienia zolwia), odwraca sie, wykonuje odpowiedni odcinek i znowu odpowiednio sie obraca.
 Sa dwie funkcje do obracania zolwia: RotP - obraca pysk zolwia i RotG - odwraca jego grzbiet.
 */

void GeneratorPunktow (Zwrot *zolw, double *x, double *y, double *z, double krok, int n, double fi, double psi, int d)
{
    if (n>0)
    {
            rotP(zolw, zolw->plec);
            rotP(zolw, rev(prawo(zolw)));
        GeneratorPunktow(zolw,x,y,z,krok, n-1, fi, psi, d);
            rotP (zolw, rev(prawo (zolw)));
        go (zolw, x,y,z,krok, fi, psi, d);
            rotG(zolw, rev(prawo(zolw)));
        GeneratorPunktow(zolw,x,y,z,krok,n-1, fi, psi, d);
            rotP(zolw,zolw->plec);
            rotP(zolw,rev(prawo(zolw)));
        go(zolw,x,y,z,krok, fi, psi, d);
            rotP(zolw, prawo(zolw));
            rotP(zolw, rev(zolw->plec));
        GeneratorPunktow(zolw,x,y,z,krok,n-1, fi, psi, d);
            rotP(zolw,prawo(zolw));
            rotP(zolw,prawo(zolw));
        go (zolw,x,y,z,krok, fi, psi, d);
            rotG(zolw, rev(prawo(zolw)));
            rotP(zolw, zolw->plec);
       GeneratorPunktow(zolw,x,y,z,krok,n-1, fi, psi, d);
            rotP(zolw, rev(prawo(zolw)));
        go (zolw,x,y,z,krok, fi, psi, d);
            rotP(zolw, prawo(zolw));
        GeneratorPunktow(zolw,x,y,z,krok,n-1, fi, psi, d);
            rotP(zolw, zolw->plec);
        go (zolw, x,y,z,krok, fi, psi, d);
            rotG(zolw, rev(prawo(zolw)));
        GeneratorPunktow(zolw,x,y,z,krok,n-1, fi, psi, d);
            rotP(zolw, rev(prawo(zolw)));
        go (zolw, x,y,z,krok, fi, psi, d);
            rotP(zolw, prawo(zolw));
        GeneratorPunktow(zolw,x,y,z,krok,n-1, fi, psi, d);
            rotP(zolw, prawo(zolw));
            rotP(zolw, prawo(zolw));
        go (zolw, x,y,z,krok, fi, psi, d);
            rotG(zolw, prawo(zolw));
            rotP(zolw, prawo(zolw));
       GeneratorPunktow(zolw,x,y,z,krok,n-1, fi, psi, d);
            rotG(zolw, rev(prawo(zolw)));
            rotP(zolw, rev(prawo(zolw)));
    }
}
void hilbert3D (int n, int s, int u, int d, int x, int y, int z, double fi, double psi)
{
    //zamiana stopni na radiany:
    double fi1=(fi*2*M_PI)/360;
    double  psi1=(psi*2*M_PI)/360 ;

    //ustawienie startu ¿ó³wia:
    double x1=(double)x-((double) u)/2;
    double y1=(double)y + ((double) u)/2;
    double z1=(double)z + ((double) u)/2;

    //wielkoœæ kroku:
    double krok = ((double) u/ (pow(2.0,(double)n)-1));

    //pozycja początkowa ¿ó³wia:
    Zwrot zolw;
    zolw.plec='U';
    zolw.pysk='S';

    //nag³ówek pliku:
    printf("%%!PS-Adobe-2.0 EPSF-2.0\n");
    printf("%%%%BoundingBox: 0 0 %d %d\n", s,s );

    //rzut startu ¿ó³wia na p³aszczyznê (najpierw obrot, potem rzut):
    double y2=y1;
    double z2=z1;
    double x2=x1;
    obrot (&x2, &z2, psi1);
    obrot (&z2, &y2, fi1);
    double x3=((d * x2)/(z2+d));
    double y3=((d * y2)/(z2+d));
    printf ("newpath %2g %2g moveto\n", x3,y3);

    //funkcja w³aœciwa
    GeneratorPunktow(&zolw, &x1,&y1,&z1,krok, n, fi1, psi1, d);

    //stopka
    printf(".4 setlinewidth\nstroke\nshowpage\n%%%%Trailer\n%%EOF");
}

int main()
{
    int n,s,u,d,x,y,z;
    double fi, psi;
//scanf("%d,%d,%d,%d,%d,%d,%d, %g, %g",n,s,u,d,x,y,z,fi, psi);
    hilbert3D(n,s,u,d,x,y,z,fi,psi);

    return 0;
}
