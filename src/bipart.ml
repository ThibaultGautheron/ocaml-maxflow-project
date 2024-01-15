open Graph
open Tools
open Flow_algo


type personne =
{ nom: id ;
  jobs: id list}

let rec generateJobsList (plist : personne list) = match plist with
| [] -> []
| p::next -> List.sort_uniq (fun a b -> a-b) (
List.merge (fun a b -> a-b) p.jobs (generateJobsList next))

let rec generateNamesList (plist : personne list) = match plist with
| [] -> []
| p::next -> p.nom::generateNamesList next

let rec generateJobNode gr idp (joblist : id list) = match joblist with
|[] -> gr
|job::next -> generateJobNode (add_arc (new_node gr job) job idp 1) idp next

let rec generateNameNode gr ids (namelist : id list) = match namelist with
|[] -> gr
|name::next -> generateNameNode (add_arc (new_node gr name) ids name 1) ids next


let rec generateArcfromName gr (p : personne ) = match p.jobs with
|[] -> gr
|j::next -> generateArcfromName (add_arc gr p.nom j 1 ) {nom = p.nom ; jobs = next}


let rec generateArcBetweenNodes gr (plist : personne list) = match plist with
|[] -> gr
|p::next -> generateArcBetweenNodes (generateArcfromName gr p) next


let cleanupBi graphD graphF =
  e_fold (cleanup graphD graphF) (fun g {src = id1; tgt = id2; lbl = i}-> let label = match (find_arc graphD id1 id2) with
  |Some myarc -> myarc.lbl
  |None -> i
in 
  new_arc g {src = id1; tgt = id2; lbl = label-i}) (clone_nodes graphD) ;;


let bipartite_matching_gr gr plist ids idp = generateArcBetweenNodes (generateNameNode (generateJobNode (new_node (new_node gr ids) idp) idp (generateJobsList plist)) ids (generateNamesList plist)) plist

let bipartite_matching gr plist ids idp = let folkflots = flots ids idp (bipartite_matching_gr gr plist ids idp) in cleanupBi (bipartite_matching_gr gr plist ids idp) folkflots

let readJobApplication list line =
  try Scanf.sscanf line "%d %d" (fun n id -> let app = {nom = n ; jobs = [id]} in if (List.exists (fun t -> t.nom = n) list) 
    then ({nom = n; jobs = id::(List.find (fun t -> t.nom = n) list).jobs } ::(List.filter (fun t -> t.nom <> n) list)) 
    else app::list)


with e ->
  Printf.printf "Cannot read node in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
  failwith "from_file"
   
let from_file_bi path =

  let infile = open_in path in

  (* Read all lines until end of file. *)
  let rec loop list =
    try
      let line = input_line infile in

      (* Remove leading and trailing spaces. *)
      let line = String.trim line in

      let list2 =
        (* Ignore empty lines *)
        if line = "" then list

        else readJobApplication list line in
          (* It should be a comment, otherwise we complain. *)  
      loop list2

    with End_of_file -> list (* Done *)
  in

  let final_list = loop [] in

  close_in infile ;
  final_list