## Extraction

This series was provided as a PyMOL session file.

> code/extract.ipynb

The bond order was absent. The hits were matched to the library (`AllChem.AssignBondOrdersFromTemplate`) 
or `OpenBabel openbabel.OBMol.PerceiveBondOrders` if not found.

![categories](images/categories.png)

## Relax

> code/relax.ipynb

x0310 template (`x0310_apo.pdb`) was remade with tweaks.

## Fragmenstein

Analogues of 2 and 3 way mergers gave a lot of catalogue virtual compounds. 250k.
75,322 were accepted by Fragmenstein.
16,189 had a negative multifactor score.
13,554 have a Tanimoto similarity of 0.8 or less to any other.

Curiously, the deeper part of the P1 sidechain pocket is populated by better ∆G compounds.

    [('hbond', 'SER', 105),
     ('hydroph_interaction', 'VAL', 124),
     ('halogenbond', 'SER', 105),
     ('hbond', 'VAL', 124),
     ('halogenbond', 'VAL', 124)]

The multifactor score does a weird split:

![img.png](images/dG-pocket.png)

Ad actually I want S105 + V124, so I will submit two datasets.

![img.png](images/atS105.png)

The outliers are many.
A conservative penalty was also tried with Butina clustering with a 0.7 threshold (Morgan, 3, 2048).

However, the problem is that the clustering makes weaker hits look better regardless of how weak they are.

|                                   |   default |   conservative |   cluster_ranked |
|:----------------------------------|----------:|---------------:|-----------------:|
| N_rotatable_bonds                 |      1    |           1    |             1    |
| ∆∆G                               |      1    |           1    |             1    |
| interaction_uniqueness_metric     |     -2.5  |           0    |             0    |
| N_unconstrained_atoms             |      0.2  |           0.25 |             0.25 |
| N_constrained_atoms               |     -0.05 |          -0.5  |            -0.5  |
| N_interactions                    |     -1.5  |          -0.5  |            -0.5  |
| N_interactions_lost               |      2    |           2    |             2    |
| max_hit_Tanimoto                  |     -0.5  |          -0.5  |            -0.5  |
| N_PAINS                           |      5    |           5    |             5    |
| strain_per_HA                     |      1    |           1    |             1    |
| intxn_cluster_rank_10             |      0    |           0    |             1    |
| farther_distance_to_substrate_mod |      0    |           0    |             1.5  |

This changes the dataset substantially:

![img.png](images/con_scatter.png)

The compounds are small and as a result there's a lot of variation on the indole ring theme,
while the all cluster in the P1 pocket.

![img.png](images/con.png)

A better solution is to use the cluster ranking as a penalty as many top intra-cluster compounds are not good.

![img.png](images/rank.png)

So when a ranking costs 1 kcal/mol, the dataset looks much more reasonable:

![img.png](images/rank-weighted.png)

About crossing to the upstream pocket, only three compounds do this
(`PV-004088162110`,  `Z1715535807`, `Z1607665206`)
![img.png](images/upstream.png)

Only Z1607665206 is decent, but boring:

![img.png](images/Z1607665206.png)



## Rocs
Multiple ROCS runs were performed with the following datasets:

* Enamine_Building_Block.oeb.gz
* Enamine_screening_collection_202312.oeb.gz
* Enamine_3D-shape.oeb.gz
* Enamine_sulfonamides.oeb.gz
* Carboxylic Acid Bioisosteres_1817cmpds.oeb.gz

But not all were brought trough to the next stage.

Fragmenstein filtering against clashes (code/rescore_rocs/ipynb).

![img.png](images/rocs.png)

## Arthorian Quest

A pyrone or a pyridone may be good, but don't seem elaboratable. So halo-pyridine is the ticket.

The sulfonamide in x0719 is very nice. However, it lacks the aza H-acceptor
and the para substituent may be better as a halogen.
That is `Z3826729512`. Although an indane-like ring is also interesting (`Z5401297840`).
For elaborability, `Z3502193859` (sulfodiamide) might be an option for some reason.

## Footnote

Is B-factor or occupancy a good metric for the quality of the hit and thus how much to weigh its derivatives?

Ryan Lithgo categories the hits based on the "quality" in Coot.
I.e. how easy were they to see.

![ryan_choices](images/ryan_choices.png)