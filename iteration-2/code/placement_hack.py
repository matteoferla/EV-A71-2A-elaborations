import numpy as np
import functools
import numpy.typing as npt
import pandas as pd
from pathlib import Path
from rdkit import Chem, Geometry, DataStructs
from rdkit.Chem import AllChem, Draw, PandasTools
from rdkit.Chem import rdMolDescriptors as rdmd
from rdkit.ML.Cluster import Butina
from sklearn.cluster import KMeans
from collections import defaultdict
from fragmenstein import Laboratory
from smallworld_api import SmallWorld, NoMatchError
import sys, os

i = int(os.environ['EXPERIMENTN'])

print(f'Subset {i}')

analogs = pd.read_pickle('fragmenstein_analogues_combined.pkl.gz').iloc[i*500:(i+1)*500]

pdbblock = Path('x0310_apo.pdb').read_text()

placements: pd.DataFrame = Laboratory._place_ops(analogs=analogs,
                                                 pdbblock=pdbblock,
                                                 n_cores=os.cpu_count() - 1,
                                                 timeout=240,
                                                 suffix='manual')

hit_replacements = pd.read_pickle('fragmenstein_hit_replacements_fragpairs.pkl.gz')
placements.to_pickle(f'fragmenstein_placements_manual{i}.pkl.gz')
Laboratory.score(placements=placements, hit_replacements=hit_replacements,
                 weights={"N_rotatable_bonds": 1,
             "\u2206\u2206G": 1,
             "interaction_uniqueness_metric": -5,
             "N_unconstrained_atoms": 0.2,
             "N_constrained_atoms": -0.05,
             "N_interactions": -1.5,
             "N_interactions_lost": 2,
             "max_hit_Tanimoto": -0.5,
             "N_PAINS": 5,
             "strain_per_HA": 1})
placements.to_pickle(f'fragmenstein_placements_manual{i}.pkl.gz')
print('complete')

sys.exit(0)