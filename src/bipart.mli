open Graph

type personne = 
{ nom: id ;
jobs: id list};;

val bipartite_matching: id graph -> id -> id -> personne list -> id graph;; 
val bipartite_matching_gr: id graph -> personne list -> id -> id -> id graph;;
