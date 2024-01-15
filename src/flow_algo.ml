open Graph
open Printf
open Tools


let write_list (list:int arc list) =
  (* Write in this file. *)
  printf  "%% This is a list.\n\n" ;
  let rec loop (list:int arc list) = match list with
    |[] -> printf  "\n%!"
    |arc::rest -> printf  " %d -> %d (%d) " arc.src arc.tgt arc.lbl; loop rest 
  in loop list;   
;;


let cleanup graph_D graph_F =
  e_fold graph_D (fun g {src = id1; tgt = id2; lbl = i} -> let label = match (find_arc graph_F id1 id2) with
  |Some myarc -> myarc.lbl
  |None -> i
in 
  new_arc g {src = id1; tgt = id2; lbl = label}) (clone_nodes graph_D) ;;

let dfs idSource idDest graph =
  let rec loop acu_vus listeArcs listeChemin = match listeArcs with
    |[] -> []
    |y::rest -> if List.exists (fun a-> a=y) acu_vus then  loop acu_vus rest (listeChemin) else match y.lbl with
      |0-> loop (y::acu_vus) rest (listeChemin)
      |_-> if y.tgt = idDest then y::listeChemin else match loop (y::acu_vus) (out_arcs graph y.tgt) (y::listeChemin) with
        |[] -> loop (y::acu_vus) rest (listeChemin)
        |z -> z
  in loop [] (out_arcs graph idSource ) []
;;

let max_flow path = 
  let rec loop path2 acu = 
    match path2 with
    |[] -> acu
    |x::rest -> if (x.lbl < acu) then loop rest x.lbl else loop rest acu in
    loop path Int.max_int
;;

let augmentation_flow path graph m= 
  let rec loop path graph m =
    match path with
    |[] -> graph
    |x::rest -> loop rest (add_arc (add_arc  graph x.tgt x.src m ) x.src x.tgt (-m)) m

  in loop path graph m
;;
let flots s t base_graph =
 
  let rec while_loop graph  =
    
    let path_dfs = dfs s t graph in (*on choisit un chemin entre s et t*)
    match (max_flow path_dfs) with (*pour chaque noeud du chemin*)
    |x-> if (x = Int.max_int) then graph else let max = x in (*sinon, on recupere la valeur du flow min*)
    
    while_loop (augmentation_flow path_dfs graph max)
      
  in while_loop base_graph

;;

