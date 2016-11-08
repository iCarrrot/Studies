#ifndef zespolone_H
#define zespolone_H
#include <stdio.h>
typedef struct Zespolone
{
    double r;
    double i;
} Zespolone;


Zespolone zes (double a, double b)
{
    Zespolone c;
    c.r=a;
    c.i=b;
    return c;
}

void printz (Zespolone a)
{
    printf ("z= %4g + %4gi\n", a.r, a.i);
}

Zespolone *dod (Zespolone a, Zespolone b)
{
    Zespolone c;
    c.r=a.r+b.r;
    c.i=a.i+b.i;
    Zespolone *wc;
    wc=&c;
    return wc;
}

void dod2 (Zespolone *a, Zespolone *b)
{
    b->r=a->r+b->r;
    b->i=a->i+b->i;
}

Zespolone *od (Zespolone a, Zespolone b)
{
    Zespolone c;
    c.r=a.r-b.r;
    c.i=a.i-b.i;
    Zespolone *wc;
    wc=&c;
    return wc;
}

void od2 (Zespolone *a, Zespolone *b)
{
    b->r=a->r-b->r;
    b->i=a->i-b->i;
}
Zespolone *mn (Zespolone a, Zespolone b)
{
    Zespolone c;
    c.r=a.r*b.r-a.i*b.i;
    c.i=a.i*b.r+a.r*b.i;
    Zespolone *wc;
    wc=&c;
    return wc;
}

void mn2 (Zespolone *a, Zespolone *b)
{
    Zespolone *c;
    c->r = a->r * b->r - a->i * b->i;
    c->i = a->i * b->r + a->r * b->i;
    b->r=c->r;
    b->i=c->i;
}

Zespolone *dziel (Zespolone a, Zespolone b)
{
    Zespolone c;
    c.r=(a.r*b.r+a.i*b.i)/(b.r*b.r+b.i*b.i);
    c.i=(a.i*b.r-a.r*b.i)/(b.r*b.r+b.i*b.i);
    Zespolone *wc;
    wc=&c;
    return wc;
}

void dziel2 (Zespolone *a, Zespolone *b)
{
    Zespolone *c;
    c->r =( (a->r) * (b->r) + (a->i) * (b->i))/((b->r)*(b->r)+(b->i)*(b->i));
    c->i =( (a->i) * (b->r) - (a->r) * (b->i))/((b->r)*(b->r)+(b->i)*(b->i));
    b->r=c->r;
    b->i=c->i;
}

#endif
