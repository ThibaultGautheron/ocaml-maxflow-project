open Graph
open Tools
open Gfile


let min_flow path = 
  let rec loop path2 acu = 
    match path2 with
    |[] -> acu
    |x::rest -> if (x.lbl < acu) then loop rest x.lbl else loop rest acu in
    loop path 0
;;

let flots s t base_graph =
  let init_graph = gmap base_graph (fun a ->  0) in 

  let rec while_loop graph graph2 =
    
    let path_dfs = dfs s t graph2 in
    match path_dfs with
    |[] -> graph
    |x -> let min = min_flow path_dfs in

      let rec for_loop path acu graph2= 
        match path with
        |[] -> while_loop acu graph2
        |x::rest -> for_loop rest (add_arc acu x.src x.tgt min) (add_arc graph2 x.src x.tgt (-min))


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