open Graph

let clone_nodes (gr : 'a graph) = n_fold gr new_node empty_graph ;;

let gmap gr f = e_fold gr (fun g {src = id1; tgt = id2; lbl = i}-> new_arc g {src = id1; tgt = id2; lbl = (f i)}) (clone_nodes gr);;

let add_arc graph id1 id2 i = 
  match (find_arc graph id1 id2) with
  |None -> new_arc graph {src = id1; tgt = id2; lbl = i}
  |Some x -> new_arc graph {src = id1; tgt = id2; lbl = x.lbl+i}
;;