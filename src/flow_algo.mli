open Graph

val dfs : id -> id -> id graph -> id arc list ;;
val write_list : int arc list -> unit;;
val flots : id->id->id graph -> id graph;;
val max_flow : id arc list -> id;;
val augmentation_flow : 'a arc list -> id graph -> id -> id graph;;
val cleanup : 'a graph -> 'a graph -> 'a graph;;