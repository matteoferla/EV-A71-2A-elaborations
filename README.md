# EV-A71-2A-elaborations
Elaborations for the XChem fragment hits against EV A71 2A protease.

## Prerequisites

Some scripts may refer to other pieces of infrastructure.
All code was run in the Iris cluster.

* [list of my scripts used in Iris cluster](https://gist.github.com/matteoferla/e0496d5766c12a0ae1738b943b41a536)
* [explanation of reverse port forwarding a Jupyter notebook from a compute node](https://www.blopig.com/blog/2023/10/ssh-the-boss-fight-level-jupyter-notebooks-from-compute-nodes/)
* [collection of scripts and notebooks normally used by me](https://github.com/matteoferla/Fragment-hit-follow-up-chemistry)

## Template Preperation

For details on the preparation of the open-state template see [template notes](template.md).

## Iterations
The ASAP followups are done in iterations, which do not correspond to cycles.
The biochemists are overburdened so the structures are released piecemeal.

| Iteration | Method          | Name in Fragalysis           | File | Enumeration/Generation                                           | Analogue-by-catalogue step                                                                             | Filtering                                                                             | Clustering and ranking                       |
|-----------|-----------------|------------------------------|------|------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|----------------------------------------------|
| 1         | Fragmenstein    | MatteoFerla-A71-Fragmenstein | -    | Fragmenstein Fragment merging                                    | Smallworld (sw.docking.org) followed by Fragmenstein placement                                         | -                                                                                     | Interaction clustered and multiparameter ranked |
| 1         | OE ROCS         | MatteoFerla-A71-ROCS-mixed   | -    | OE ROCS shape and colour search                                  | Already in catalogue                                                                                   | Fragmenstein placement against themselves (against clashes).                          | as above                                     |
| 1         | OE ROCS         | MatteoFerla-A71-ROCS-cov     | -    | OE ROCS shape and colour search                                  | Already in catalogue                                                                                   | As above but covariant datasets filtered by distance of warhead to catalytic cysteine | as above                                     |
| 1         | Arthorian quest | MatteoFerla-A71-Arthor       | -    | Arthorian Quest (arthor.docking.org search of degenerate SMARTS) | Already in catalogue                                                                                   | degenerate SMARTS used for enumeration, followed by placement against query.          | as above                                     |
| 1         | SILVR*          | JenkeScheen-A71-SILVR        | -    | SILVR (deep learning generation)                                 | Chemistry correction, RDKit only Fragmenstein placement against self, then SmallWorld and Fragmenstein | -                                                                                     | as above                                     |
| 2         | OE ROCS         | MatteoFerla-A71-ROCS-iter2   | -    | OE ROCS shape and colour search                                  | Already in catalogue                                                                                   | Fragmenstein placement against themselves (against clashes).                          | as above                                     |
| 2         | Fragmenstein    | MatteoFerla-A71-Fragmenstein-iter2-hybrid   | -    | Fragmenstein Fragment merging                                  | Already in catalogue                                                                                   | Fragmenstein placement against themselves (against clashes).                          | as above                              |



(*) SILVR was run by Jenke Scheen, I simply run the catalogue search onwards.

See [iteration 1/README.md](iteration%201/README.md) for details.

## Scan for open state

See [open_scan/README.md](open_scan/README.md) for details.

In silico mutational scanning of closed and open states to find variants that favour the open state.

## Analyses
See [analyses/README.md](analyses/README.md) for details.

* MD run, creation of water map
* Ligand from 7DA6 in x310 template
* AF2 modelling