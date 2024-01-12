open Gfile
open Tools
open Bipart

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file for applications list \n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  
  let outfile = Sys.argv.(4)
  and infile = Sys.argv.(1)

  (* These command-line arguments are not used for the moment. *)
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in

  (*let p1 = {nom = 101; jobs = [12]} in
  let p2 = {nom = 102; jobs = [12]} in
  let p3 = {nom = 103; jobs = []} in

  let plist = [p1; p2; p3] in*)



  let bipGraph = bipartite_matching Graph.empty_graph (from_file_bi infile) source sink  in
  let graph_str = gmap bipGraph (fun a -> string_of_int a) in
  let () = export graph_str outfile in
  ();

