open Gfile
open Tools
open Flow_algo

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph =  from_file infile in
  let graph1 = gmap graph (fun a -> int_of_string a) in
  
  (*let graph2 = add_arc graph1 1 3 17 in
  let graph3 = gmap graph2 (fun a -> string_of_int a) in*)

  (* Rewrite the graph that has been read. *)
  (*let () = write_file outfile graph3*)
 
  let dfs_graph1 = dfs 0 5 graph1 in 
  let max_flow_graph1 = max_flow dfs_graph1 in 
  Printf.printf "%d\n" max_flow_graph1;
  let aug_flow = flots source sink graph1 in
  let clean = cleanup graph1 aug_flow in
  let graph_str = gmap clean (fun a -> string_of_int a) in
  let () = export graph_str outfile in
  ();
  
  

