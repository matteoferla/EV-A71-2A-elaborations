## Mutational scanning

There are two conformations.
In solution (openMM) and in crystal (experimental) the closed conformation is favoured.

What mutations favour the open conformation?

PyRosetta 8Å cutoff, 5 FastRelax cycles for each mutation against open and closed in triplicate.

The triplicates have very small differences. They should have been on minimised backrub or alt templates.
However, the fact that there are so many explainable mutants affecting the same residue is good.
So triplicates may be unnecessary.

The silent mutation control: 0.6 kcal/mol MAE.
The residue specific version was removed from the final ∆∆∆G.

The shortlist was mutations that are stabilising on open and destabilising on closed,
with a denoised ∆∆∆G of –2 kcal/mol or less.

These were the relaxed with a 2x of a constraint between Y89.OH and S125.O 
that at 7 Å is 2 kcal/mol and at 3Å it's zero; namely pulling the loop back in to antagonise the openness.

Intriguingly the following are the shortlist:

Y89SNDQAKHF, S87DRCE, A92HYFN, T45DI, Y90RV, C110FY, G127SM, H21Q, C56I, E88P, R93F

1. The most common is `Y89X`, which is comical as that is the problem child we want to keep open.
2. S87 faces the active site so is an obvious cheat.
3. A92 — This and R93F are causing a very large loop movement, somehow, causing Y89 to be very open. This may affect packing and has an artefactual sulfate next to it in the crystal
4. T45X is a buried far residue that does not really propagate to H21 and Y89 (see picture)
5. Y90 is involved with Y89
6. C110 and H21 are the catalytic residues, so they are not going to be mutated.
7. Like S87X G127SM is a cheat.
8. C56 coordinates a Zinc (absent) —ignore
9. E88P is interesting, but actually causes Y89 to flip inwards in the open model (so orients the loop like the open but Y89 itself is closed), also raising the pI of the protein might be a problem.
10. R93F is causing a very large loop movement, somehow, causing Y89 to be very open

## Future
The issue is that the open conformation is not stable, so odd things happen.
Maybe I should have done it with the native ligand or an XChem hit in place, 
but I didn't.
The native ligand pose is more open than the XChem hits, which has been contentious.
The XChem hits are small and may be easily dislogged causing blow-ups.



