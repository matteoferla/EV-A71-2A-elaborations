# EV-A71-2A-elaborations
Elaborations for the XChem fragment hits against EV A71 2A protease.

## States

> See Notion page

The following hits are in the substrate-bound pose: 

`['x0451_0A', 'x0554_0A', 'x0554_1A', 'x0554_2A', 'x0566_0A', 'x0269_0A', 'x0269_1A', 'x0310_0A', 'x0341_0A', 'x0341_1A', 'x0395_0A', 'x0395_1A']`

The following are in the apo / product-bound pose:

`['x0469_0A', 'x0473_0A', 'x0486_0A', 'x0517_0A', 'x0525_0A', 'x0526_0A', 'x0540_0A', 'x0541_0A', 'x0556_0A', 'x0586_0A', 'x0278_0A', 'x0278_1A', 'x0305_0A', 'x0309_0A', 'x0326_0A', 'x0608_0A', 'x0608_1A', 'x0691_0A', 'x0152_0A', 'x0152_1A', 'x0188_0A', 'x0202_0A', 'x0211_0A', 'x0211_1A', 'x0211_2A', 'x0228_0A', 'x0229_0A', 'x0229_1A', 'x0239_0A', 'x0332_0A', 'x0354_0A', 'x0359_0A', 'x0379_0A', 'x0396_0A', 'x0412_0A', 'x0416_0A', 'x0428_0A']`

## P1 hits

> See Notion page

`['x0451_0A', 'x0554_0A', 'x0556_0A', 'x0566_0A', 'x0310_0A', 'x0416_0A']`

## Template

PDB:7DA6 is in the open / substrate bound form.
It does not deviate too much from the XChem structures bar the everting SEYYP loop (cf Tyr89) and catalytic Cys110.


* PDB:7DA6 C100A energy minimised against its electron density with PyRosetta
* aligned against XChem hits
* mutated the A100C back
* stripped of non-polymers and peptide chain C

The Dunbrack rotamer is perfectly placed for H-bonding with His21,
but I didn't bother changing the protonation (CYS110 to CYZ, HID21 to HIE, ASP39 to ASH).

## OE Rocs

Multiple datasets from Enamine libraries were made and tested against the P1 hits + peptide.

These were then 'redocked' with Fragmenstein and sorted by energy.
For reactives, The distance to the reactive group was also calculated and everything with 3Å was kept.

