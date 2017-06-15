simpex(a)-->[a].
simpex(b)-->[b].
simpex(E)-->['('],expr(E),[')'].
expr(E)-->simpex(S),[*],!,expr
