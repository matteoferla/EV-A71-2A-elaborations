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

## Iteration 1
The ASAP followups are done in iterations, which do not correspond to cycles.
The biochemists are overburdened so the structures are released piecemeal.

Three groups of experiments were done:

* Fragmenstein: fragment merging, followed by placement of analogues-by-catalogue. Interaction clustered and multiparameter ranked.
* OE ROCS: shape and colour search. Followed by Fragmenstein placement against themselves.
* Arthorian quest: degenerate SMARTS used for enumeration, followed by placement against query.
