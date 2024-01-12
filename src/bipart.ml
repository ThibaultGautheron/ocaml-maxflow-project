open Graph
open Tools
open Flow_algo

(* 
0)Creer graphe
1) constituer K liste de tous les metiers, les mettre a droite, ajouter un arc au puit a droite -> Parc = 1
   2) constiture N liste de tous les noms, les mettre a gauche, ajouter un arc a la source a gauche -> Parc = 1
   3) si k dans la liste d une personne, ajouter un arc entre son nom et K -> Parc = 1
*)


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
  e_fold (cleanup graphD graphF) (fun g {src = id1; tgt = id2; lbl = i} -> match i with
  |0 -> Some i
  |_ -> None
in 
  new_arc g {src = id1; tgt = id2; lbl = i}) (clone_nodes graph) ;;

let bipartite_matching_gr gr plist ids idp = generateArcBetweenNodes (generateNameNode (generateJobNode (new_node (new_node gr ids) idp) idp (generateJobsList plist)) ids (generateNamesList plist)) plist

let bipartite_matching gr ids idp plist = let folkflots = flots ids idp (bipartite_matching_gr gr plist ids idp) in cleanupBi folkflots
