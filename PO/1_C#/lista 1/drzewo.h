#ifndef drzewo_H
#define drzewo_H
#include <stdio.h>
typedef struct node
{
    int val;
    struct node *left;
    struct node *right;
} node;


node *utworz(int wart)
{
    node *pom;
    pom = (node*) malloc(sizeof(node));
    pom->left = NULL;
    pom->right = NULL;
    pom->val = wart;
    return pom;
}

node *wstaw( node *root, int nkey)
{
    if(root==NULL)
        return utworz(nkey);
    if (nkey < root->val)
        root->left =wstaw(root->left, nkey);
    else if (nkey > root->val)
        root->right =wstaw(root->right, nkey);
    return root;
}


node *searching(node *root, int val)
{
    if (root==NULL || root->val== val)
        return root;
    if (root->val>val)
        return searching(root->left, val);
    else
        return searching(root->right, val);

}

int rozmiar (node *root)
{
    if (root==NULL)
        return 0;
    else
        return 1+ rozmiar (root->left)+rozmiar(root->right);
}

#endif
