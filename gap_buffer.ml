open Str;;
open Ast;;

type 'a gap_buffer = 'a list * 'a list * 'a list ;;

let print_list list = 
  List.iter (Printf.printf "%s \n") list
;;

let rec cut len list = 
  match len with
  |0-> ([],list)
  |n-> match list with 
      |[]-> ([],[])
      |hd::tl -> 
        let (before,after) = cut (n-1) tl in 
        (hd::before,after) 
;;

let print_gap (before,after,paste) =
  Printf.printf "Before :\n"; print_list (List.rev before);
  Printf.printf "After :\n"; print_list after;
  Printf.printf "Paste :\n"; print_list (List.rev paste);
;;

let create_gap str paste=
  let trimmed = String.trim str in 
  let after = String.split_on_char ' ' trimmed in 
  ([], after, paste)
;;

let gap_move (before,after,paste) =  function
  |Home -> ([],(List.rev before)@after,paste)
  |End -> ((List.rev after)@before,[],paste)
  |Wordmove(number,direction)-> 
    match direction with 
    |Right->
      let (add,rest) = cut number after in
      ((List.rev add)@before,rest,paste)
    |Left -> 
      let (add,rest) = cut number before in
      (rest,(List.rev add)@after,paste)
;;      

let gap_insert (before,after,paste) value = 
  let array = String.split_on_char ' ' value in 
  ((List.rev array)@before,after,paste)

let gap_delete (before, after,_) = function
  |Home -> ([],after,before) 
  |End -> (before,[],after) 
  |Wordmove(number,direction)->
    match direction with
    |Right -> 
      let (remove,rest) = cut number after in 
      (before,rest, List.rev remove)
    |Left -> 
      let (remove,rest) = cut number before in 
      (rest,after,remove)
;;

let gap_copy (before,after,_) = function
  |Home -> (before,after,before) 
  |End -> (before,after,(List.rev after)) 
  |Wordmove(number,direction)->
    match direction with
    |Right -> 
      let (copy,_) = cut number after in 
      (before,after, List.rev copy)
    |Left -> 
      let (copy,_) = cut number before in 
      (before,after,copy)  
;;

let gap_paste (before,after,paste) = 
  let conc = paste@before in 
  (conc,after,paste)
;;

let gap_to_string (before,after,_) = 
  let full = (List.rev before)@after in
  String.concat " " full;
;;

let gap_subtitute gap pattern replacement = 
  let (_,_,paste) = gap in
  let str = gap_to_string gap in 
  let rpattern = Str.regexp pattern in 
  let returnStr = Str.global_replace rpattern replacement str in 
  create_gap returnStr paste
;;


