open Gfile
open Tools
open Bipart
open Flow_algo

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 6 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  test version  : if 0 then we test Folk-Fulderson, if 1 we test Bipartite matching \n" ^
         "    🟄  infile  : input file for applications list \n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;



  (* Arguments are : version(1) infile(2) source-id(3) sink-id(4) outfile(5) *)
   
  let infile = Sys.argv.(2)
  and outfile = Sys.argv.(5)
  and source = int_of_string Sys.argv.(3)
  and sink = int_of_string Sys.argv.(4)
  and version = int_of_string Sys.argv.(1)
  in

  (*Version = 1 : Bipartite Matching *)
  if (version == 1) then 
  let bipGraph = bipartite_matching Graph.empty_graph (from_file_bi infile) source sink  in
  let graph_str = gmap bipGraph (fun a -> string_of_int a) in
  let () = export graph_str outfile in
  ();

else
  (*Version = 0 : Ford-Fulkerson algorithm *)
  let graph =  from_file infile in
  let graph1 = gmap graph (fun a -> int_of_string a) in

  let aug_flow = flots source sink graph1 in
  let clean = cleanup graph1 aug_flow in
  let graph_str = gmap clean (fun a -> string_of_int a) in
  let () = export graph_str outfile in
  ();


