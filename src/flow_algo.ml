open Graph
open Tools
open Gfile



let dfs_start s t graph = 
  let rec loop acu =
    match out_arcs graph s with
    |[] -> acu 
    |x::rest -> check_neighbors s t graph
;;

let check_neighbors current_node goal graph = if (find (fun x -> x = goal) (out_arcs graph current_node)) = Not_found then None else Some x

;;

let min_flow path = 
  let rec loop path2 acu = 
    match path2 with
    |[] -> acu
    |x::rest -> if (x.lbl > acu.lbl) then loop rest x else loop rest acu in
    loop path (List.hd path)
;;

let flots s t base_graph =
  let init_graph = gmap base_graph (fun a -> string_of_int 0) in 

  let rec while_loop graph graph2 =
    
    let path_dfs = dfs_start s t graph2 in
    match path_dfs with
    |[] -> graph
    |x::_ -> let min = min_flow path_dfs in

      let rec for_loop path acu graph2= 
        match path with
        |[] -> while_loop acu graph2
        |x::rest -> for_loop rest (gmap (add_arc (gmap (acu) (fun a -> int_of_string a)) x.src x.tgt min) (fun a -> string_of_int a)) 
        (gmap (add_arc (gmap (graph2) (fun a -> int_of_string a)) x.src x.tgt (-min)) (fun a -> string_of_int a))


      in for_loop path_dfs graph graph2
    in while_loop init_graph init_graph
    
;;

(*
s ← pick(v)

t ← pick(v)

BEGIN

(* Initializing the flow *)

FOR { e  ∈ E } DO

  f(e) ← 0

(* Main Loop *)

WHILE path might exist DO

  path ← FIND_PATH(s,t)

  augmentation ← min(e ∈ path)

  FOR {e ∈ path}

    flow(e) ← flow(e) + augmentation

END

*)