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

Therefore, I will submit two datasets.

![img.png](images/atS105.png)

About crossing to the upstream pocket, only three compounds do this
(`PV-004088162110`,  `Z1715535807`, `Z1607665206`)
![img.png](images/upstream.png)


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

## Footnote

Is B-factor or occupancy a good metric for the quality of the hit and thus how much to weigh its derivatives?

Ryan Lithgo categories the hits based on the "quality" in Coot.
I.e. how easy were they to see.

![ryan_choices](images/ryan_choices.png)