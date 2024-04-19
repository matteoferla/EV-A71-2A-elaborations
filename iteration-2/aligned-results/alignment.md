The template changed location.

The code to change position is

```python
from rdkit import Chem
from rdkit.Chem import AllChem
right: Chem.Mol = ... # the wanted position
wrong: Chem.Mol = ... # the current position
affine_matrix = AllChem.GetAlignmentTransform(wrong, right)[1]
AllChem.TransformConformer(wrong.GetConformer(), affine_matrix)
```

Snippet:

```python
from pathlib import Path
from rdkit import Chem
from rdkit.Chem import AllChem
right = Chem.MolFromMolFile('/Users/user/Downloads/A71EV2A/aligned_files/Ax0310a/Ax0310a_ligand.mol')
block = '\n'.join([l for l in Path('/Users/user/Coding/ASAP/EV-A71-2A-protease/repo/iteration-2/misc/x0310_raw.pdb').expanduser().read_text().split('\n') if ' LIG ' in l])
wrong = Chem.MolFromPDBBlock(block)
wrong = AllChem.AssignBondOrdersFromTemplate(right, wrong)
affine_matrix = AllChem.GetAlignmentTransform(wrong, right)[1]
#AllChem.TransformConformer(wrong.GetConformer(), affine_matrix)

def fix_names(names):
    skippables = ['x0929_0A']
    return ','.join(['A'+name.split('_')[0] + name[-1].lower() for name in names.split(',') if name not in skippables])

def fix_prop(mol, name):
    value = mol.GetProp(name)
    mol.SetProp(name, fix_names(value))

with Chem.SDMolSupplier('/Users/user/Coding/ASAP/EV-A71-2A-protease/repo/iteration-2/results/A71-Fragmenstein-iter2-hybrid.sdf') as sdfh:
    vcs = list(sdfh)
    
with Chem.SDWriter('/Users/user/Coding/ASAP/EV-A71-2A-protease/repo/iteration-2/aligned-results/A71-Fragmenstein-iter2-hybrid.sdf') as sdfh:
    for mol in vcs:
        if mol.HasProp('ref_pdb'):
            fix_prop(mol, 'ref_pdb')
            fix_prop(mol, 'ref_mols')
            AllChem.TransformConformer(mol.GetConformer(), affine_matrix)
    for mol in vcs:
        sdfh.write(mol)
```
