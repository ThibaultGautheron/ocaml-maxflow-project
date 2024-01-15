# OCaml Maxflow Project
By Jérémy BOIREAU & Thibault GAUTHERON

## Code Structure
This project is composed of 5 modules, a main file, ftest.ml and a Makefile:
 - Graph: contains functions related to graphs.
 - Gfile: contains functions to read and write into files.
 - Tools: contains functions for the use of graphs.
 - Flow Algo: implements functions of the Ford-Fulkerson algorithm.
 - Bipart: implements functions of the Bipartite Matching problem.


## Compilation and execution:
With our makefile, there are some useful commands:
 - `make build` to compile. This create a ftest.exe.
 - `make ford` to run the `ftest` program with some arguments (10 example graphs available)
 - `make bipartite` to run the `ftest` program with some arguments (3 examples bipartite graphs available)