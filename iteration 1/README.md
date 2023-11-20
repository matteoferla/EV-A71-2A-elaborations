# Iteration 1

## Hits

![hits](iteration 1/input/hits.png))

> See [ED minimisation notebook](iteration 1/code/extract2.ipynb)
> See Notion re RMSD of states

This is a variant of the code in [GitHub:matteoferla/Fragment-hit-follow-up-chemistry](https://github.com/matteoferla/Fragment-hit-follow-up-chemistry)
where its better documented
But this contains spatial comparisons with the [native-like ligand](iteration 1/input/peptide.mol) from 6DA7 but aligned to XChem structures.

`['x0451_0A', 'x0554_0A', 'x0556_0A', 'x0566_0A', 'x0310_0A', 'x0416_0A']`

Regarding states:

The following hits from iteration 1 are in the substrate-bound pose: 

`['x0451_0A', 'x0554_0A', 'x0554_1A', 'x0554_2A', 'x0566_0A', 'x0269_0A', 'x0269_1A', 'x0310_0A', 'x0341_0A', 'x0341_1A', 'x0395_0A', 'x0395_1A']`

The following are in the apo / product-bound pose:

`['x0469_0A', 'x0473_0A', 'x0486_0A', 'x0517_0A', 'x0525_0A', 'x0526_0A', 'x0540_0A', 'x0541_0A', 'x0556_0A', 'x0586_0A', 'x0278_0A', 'x0278_1A', 'x0305_0A', 'x0309_0A', 'x0326_0A', 'x0608_0A', 'x0608_1A', 'x0691_0A', 'x0152_0A', 'x0152_1A', 'x0188_0A', 'x0202_0A', 'x0211_0A', 'x0211_1A', 'x0211_2A', 'x0228_0A', 'x0229_0A', 'x0229_1A', 'x0239_0A', 'x0332_0A', 'x0354_0A', 'x0359_0A', 'x0379_0A', 'x0396_0A', 'x0412_0A', 'x0416_0A', 'x0428_0A']`

## Fragmenstein

### Decomposition
The P1 site hits were fragmented by BRICS decomposition plus an extra step wherein fused rings are split.
The [fragment script](https://github.com/matteoferla/Fragment-hit-follow-up-chemistry/blob/main/followup/fragment.py)
This is unusual but useful as many fused rings are not productive together and one is just piggybacking with no GE.

```python
from gist_import import GistImporter

frag = GistImporter.from_github('https://raw.githubusercontent.com/matteoferla/Fragment-hit-follow-up-chemistry/main/followup/fragment.py')\
                   .to_module('frag')
fhits: List[Chem.Mol] = []
for hit in hits:
    fhits.extend( frag.fragmént(hit, minFragmentSize=7, fused_splitting=True) )

fhits = frag.remove_duplicated(fhits)
```

### Run
The [script job.sh](iteration 1/code/job.sh) was run in the Iris cluster from a submitter node (`pool-htcondor-submitter.diamond.ac.uk`)

```bash
export JOB_SCRIPT=/data/xchem-fragalysis/shared/singularity.sh;
export APPTAINER_CONTAINER=/data/xchem-fragalysis/shared/singularity/rockyplus.sif;
export JOB_INNER_SCRIPT=/data/xchem-fragalysis/mferla/ASAP/A71/job.sh;
condor_submit /data/xchem-fragalysis/shared/target_script.condor -a 'Requirements=(machine == "orpheus-worker-39.novalocal")'
```

If you have a Diamond FedID and want to run this code and are in XChem, you might need to ask for access to the 
`xchem-fragalysis` cephFS folder or create a mounted drive (see podman notes) or \
make the HTCondor transfer the files on completion (risky).

### Polishing
The data is technically ranked already, but I want to combine different runs
and cluster again. See [polish notebook](iteration 1/code/polish.ipynb)* for more —as in políshing, not Pólish (polska),
I did not try but this is second time in a readme that I get a noun/verb spelling ambiguity :shrug:.

The default 'acceptable' `outcome` was used:

```python
combo = pd.concat([pairs, trio], ignore_index=True)
analogs = combo.loc[combo.outcome == 'acceptable'].copy();
```
From 41 fragment hits + synthons, I got 9,250 pairs and 6,031 trios, for a total of 15,281,
of which 1,583 were acceptable. The trio combination is lower than pairs as it does not include timeouts (too contorted)
and distance errors.

Along with the default weights:

```python
weights = {"N_rotatable_bonds": 1.5,
             "\u2206\u2206G": 1,
             "interaction_uniqueness_metric": -3,
             "N_unconstrained_atoms": 0.2,
             "N_constrained_atoms": -0.1,
             "N_interactions": -2,
             "N_interactions_lost": 2,
             "max_hit_Tanimoto": -0.3,
             "N_PAINS": 7,
             "strain_per_HA": 0.3}

Laboratory.score(analogs, ref,
                 suffix='',
                 hits=hits,
                 weights=weights,)

analogs['full_penalty'] = analogs.ad_hoc_penalty
```
I switch around what scoring metric I use for clustering by interaction.
The interaction data is binary, zero-inflated and covariant...
..and I am not sure myself what I want more, but generally in order the following:

1. kmeans: probability scaled PLIP interactions to prioritise rarer interactions
2. kmeans: scaled by fake enthalpic kcal/mol values of ideal interaction to devalue hydrophobic interactions 
3. kmodes (Huang): raw binary PLIP interactions

Due to the fact that the hits are so clustered, the first is a bad idea.
Only 10 clusters were used (normally I go for 25).

![mergers](iteration 1/results/mergers_itxn_clusters.png)
![mergers](iteration 1/results/mergers_itxn_clusters-zoom.png)

### Price

The price for each compound was obtained manually.
Were I to do it by webscraping I would use this [price notebook](iteration 1/code/price.ipynb).
Web scraping is technically legal, but may not be welcome: in Enamine Store the Incapsula service is used.
Residential IPs are a no-go, but academic ones are fine.
Frequent queries get a ban, hence the 20 second sleep between query.

## OE Rocs

Multiple datasets from Enamine libraries were made and tested against the P1 hits + peptide.

### Datasets
> See [OE conformer generation notebook](iteration 1/code/targetted.ipynb)
> 
* Enamine_3D-shape_Diverse_Fragment_Library_plated_1200cmds_20210527.oeb.gz
* Enamine_PPI_Fragment_Library_plated_3600cmds_20200524.oeb.gz
* Enamine_Covalent_Heterocyclic_Fragment_Library_57cmpds_20230920.oeb.gz
* Enamine_Covalent_Screening_Library_11760cmpds_20231027.oeb.gz
* Enamine_Electrophilic_Covalent_Probe_Library_ECPL_plated_960cmpds_20221114.oeb.gz
* Enamine_Quaternised_Covalent_Heterocyclic_Fragment_Library_85cmpds_20230918.oeb.gz

Along with the Enamine Building block catalogue subset with zero or one rotatable bond.

As these datasets are >10GB, I have not shared them, but if keen please let me know.
I have several more.

### Run
I created a query via the GUI.
The shape and colour metrics were rather different for the datasets due to their sizes.

![unequal](iteration 1/results/ROCS-unequal.png)

These were then 'redocked' with Fragmenstein and sorted by energy —see [rescore ROCS notebook](iteration 1/code/rescore_rocs.ipynb)
For reactives, The distance to the reactive group was also calculated and everything with 3Å was kept.

Oddly, prices were not available even if they are from plates ready to be bought.

## Arthorian Quest

To add

## Plots

Diversity:

![hamming](iteration 1/results/ROCS-hamming.png)

(For personal reference as the discussion of why Euclidean distance is unsuitable for binary data,
in the results is the same with Euclidean distance (incorrect) and Hamming distance (correct))>

The three datasets are quite different:

![3datasets](iteration 1/results/tSNE-3datasets.png)