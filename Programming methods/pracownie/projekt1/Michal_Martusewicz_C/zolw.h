#ifndef zolw_H
#define zolw_H
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>

typedef struct Zwrot
{
    char pysk;
    char plec;
} Zwrot;

//obrót punktów na p³aszczyŸnie:
void obrot(double *x, double *y, double fi)
{
    double x1=(*x)*cos(fi)-(*y)*sin(fi);
    double y1=(*x)*sin(fi)+(*y)*cos(fi);
    *x=x1;
    *y=y1;
}
//idź naprzód:
void go ( Zwrot *zolw, double   *x, double *y, double *z, double krok, double fi, double psi, int d)
{
    switch (zolw->pysk)
    {
    case 'N':
        *z+=krok;
        break;
    case 'S':
        *z-=krok;
        break;
    case 'W':
        *x-=krok;
        break;
    case 'E':
        *x+=krok;
        break;
    case 'U':
        *y+=krok;
        break;
    case 'D':
        *y-=krok;
        break;
    }
//obrót punktów w przestrzeni o fi i psi:
    double y1=*y;
    double z1=*z;
    double x1=*x;
    obrot (&x1, &z1, psi);
    obrot (&z1, &y1, fi);

//rzut punktów na p³aszczyźnie:
    double x2=((d * x1)/(z1+d));
    double y2=((d * y1)/(z1+d));

    printf ("%2g %2g lineto\n", x2,y2);


}
//odwrotny kierunek do podanego:
char rev(char kierunek)
{
    char k2;
    switch (kierunek)
    {
    case 'N':
        k2 = 'S';
        break;
    case 'S':
        k2='N';
        break;
    case 'W':
        k2='E';
        break;
    case 'E':
        k2='W';
        break;
    case 'U':
        k2='D';
        break;
    case 'D':
        k2='U';
        break;
    }
    return k2;
}
//obróæ pysk:
void rotP(Zwrot *zolw,char kier)
{
    if (zolw->plec==kier)
    {
        zolw->plec=rev(zolw->pysk);
        zolw->pysk=kier;
    }
    else if(zolw->plec==rev(kier))
    {
        zolw->plec=zolw->pysk;
        zolw->pysk=kier;
    }
    else
    {
        zolw->pysk=kier;
    }
}

//obróæ grzbiet:
void rotG(Zwrot *zolw, char kier)
{
    if (zolw->pysk==kier)
    {
        zolw->pysk=rev(zolw->plec);
        zolw->plec=kier;
    }
    else if(zolw->pysk==rev(kier))
    {
        zolw->pysk=zolw->plec;
        zolw->plec=kier;
    }
    else
    {
        zolw->plec=kier;
    }
}
//Wyznacz prawa strone zolwia:
char prawo (Zwrot *zolw)
{
    char k2;
    switch (zolw->pysk)
    {
    case 'N':
        switch (zolw->plec)
        {
        case 'W':
            k2='U';
            break;
        case 'E':
            k2='D';
            break;
        case 'D':
            k2='W';
            break;
        case 'U':
            k2='E';
            break;
        }
        break;
    case 'S':
        switch (zolw->plec)
        {
        case 'W':
            k2='D';
            break;
        case 'E':
            k2='U';
            break;
        case 'D':
            k2='E';
            break;
        case 'U':
            k2='W';
            break;
        }
        break;
    case 'W':
        switch (zolw->plec)
        {
        case 'D':
            k2='S';
            break;
        case 'U':
            k2='N';
            break;
        case 'N':
            k2='D';
            break;
        case 'S':
            k2='U';
            break;
        }
        break;
    case 'E':
        switch (zolw->plec)
        {
        case 'D':
            k2='N';
            break;
        case 'U':
            k2='S';
            break;
        case 'N':
            k2='U';
            break;
        case 'S':
            k2='D';
            break;
        }
        break;
    case 'U':
        switch (zolw->plec)
        {
        case 'W':
            k2='S';
            break;
        case 'E':
            k2='N';
            break;
        case 'N':
            k2='W';
            break;
        case 'S':
            k2='E';
            break;
        }
        break;
    case 'D':
        switch (zolw->plec)
        {
        case 'W':
            k2='N';
            break;
        case 'E':
            k2='S';
            break;
        case 'N':
            k2='E';
            break;
        case 'S':
            k2='W';
            break;
        }
        break;
    }
    return k2;
}

#endif
