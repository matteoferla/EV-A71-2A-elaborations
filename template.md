# Template v. 2

> See [ED minimisation notebook](iteration 1/code/ed_min.ipynb)
> See this blog post for details [on ED minimisation in PyRosetta](https://blog.matteoferla.com/2020/04/how-to-set-up-electron-density.html)

> For details on the two states see [Notion page](https://www.notion.so/asapdiscovery/A71-2A-Details-ef8bd9b8945943359577a7b1276c973b)
> Raise an issue if you want this doc moved here

PDB:7DA6 is in the open / substrate bound form.
It does not deviate too much from the XChem structures bar the everting SEYYP loop (cf Tyr89) and catalytic Cys110.


* PDB:7DA6 C100A energy minimised against its electron density with PyRosetta
* aligned against XChem hits
* mutated the A100C back
* stripped of non-polymers and peptide chain C

The Dunbrack rotamer is perfectly placed for H-bonding with His21,
but I didn't bother changing the protonation (CYS110 to CYZ, HID21 to HIE, ASP39 to ASH).
For MPro I had added a way to fix the pose (before the days PyRosetta could pickle poses easily), but it is 100% overkill.

# Template x0310

In the interest of fidelity to the crystal structures made by DLS XChem as opposed to RCSB PDB structures,
which are not in Fragalysis.

x0310 was minimised in PyRosetta without the ligand.

```python
pr_scoring: ModuleType = pyrosetta.rosetta.core.scoring
...
scorefxn: pr_scoring.ScoreFunction = pyrosetta.get_fa_scorefxn()
scorefxn.set_weight(pr_scoring.ScoreType.coordinate_constraint, 2.)
pyrosetta.rosetta.basic.options.set_boolean_option('relax:constrain_relax_to_start_coords', True)
pyrosetta.rosetta.basic.options.set_boolean_option('relax:coord_constrain_sidechains', True)
pyrosetta.rosetta.protocols.relax.FastRelax.register_options()
relax = pyrosetta.rosetta.protocols.relax.FastRelax(scorefxn, 15)
relax.apply(pose)
```