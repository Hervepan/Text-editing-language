open Parser 
open Ast 
open Gap_buffer

let lastline filename =
  let rec count_aux file acc =
    try
      let _ = input_line file in
      count_aux file (acc + 1)
    with
    | End_of_file ->
      close_in file;
      acc
  in
  let file = open_in filename in
  let line_count = count_aux file 1 in
  close_in file;
  line_count
;;

let rec get_linenumber lastline ast =
  match ast with
  | [] -> []
  | Line_command (num, _) :: lcommands ->
    let rest = get_linenumber lastline lcommands in
    if num <= lastline then num :: rest else raise (Failure "Error: line out of range")
;;

let lineToEdit filename lineNumbers =
  let file = open_in filename in
  let rec read_lines acc lineNumber =
    try
      let line = input_line file in
      if (List.mem lineNumber lineNumbers) then
        read_lines ((lineNumber, line) :: acc) (lineNumber + 1)
      else
        read_lines acc (lineNumber + 1)
    with
    | End_of_file ->
      close_in file;
      List.rev acc
  in
  read_lines [] 1
;;

let rec removeLine lineToEdit number = 
  match lineToEdit with
  |[]->[]
  |hd::tl -> 
    let (linenumber,_) = hd in
    if linenumber = number then tl
    else  hd::(removeLine tl number)
;;

let updateLine lineToEdit number str = 
  let update = removeLine lineToEdit number in 
  (number,str)::update 
;;
  
let rec expand_ast lastline = function 
  |[]->[]
  |Line_command(-1,commands)::tl-> (List.init (lastline-1) (fun x -> Line_command(x+1,commands)))@tl 
  |Line_command(-2,commands)::tl-> Line_command(lastline-1,commands)::tl
  |hd::tl -> hd::(expand_ast lastline tl)
;;

let evaluate_command gap command = 
  match command with 
  |Insert(str)-> Gap_buffer.gap_insert gap str
  |Move(move)-> Gap_buffer.gap_move gap move
  |Substitute(pattern,replacement) -> Gap_buffer.gap_subtitute gap pattern replacement
  |Execute(execute) ->  
    (let gap_buffer = Gap_buffer.gap_move gap Home in 
    match execute with 
      |Delete -> Gap_buffer.gap_delete gap_buffer End
      |Copy -> Gap_buffer.gap_copy gap_buffer End
      |Paste -> Gap_buffer.gap_paste gap ;)
  |Full_command(execute,move) -> 
    (match execute with 
      |Delete -> Gap_buffer.gap_delete gap move
      |Copy -> Gap_buffer.gap_copy gap move
      |Paste -> let gap_buffer = Gap_buffer.gap_move gap move in 
        Gap_buffer.gap_paste gap_buffer)
;;

let rec evaluate_linecommands gap commands = 
  match commands with
  |[]-> let (_,_,paste)= gap in
      (Gap_buffer.gap_to_string gap,paste)
  |command::rest-> 
    let new_gap  = evaluate_command gap command in
    evaluate_linecommands new_gap rest 
;;
 
let rec evaluate_ast lineToEdit ast paste =
  match ast with
  |[]-> lineToEdit
  |Line_command(line_number,commands)::lcommands -> 
    let associated_line = List.assoc line_number lineToEdit in 
    let gap = Gap_buffer.create_gap associated_line paste in 
    let (update_line,new_paste) = evaluate_linecommands gap commands in
    let update_editline = updateLine lineToEdit line_number update_line in
    evaluate_ast update_editline lcommands new_paste ; 
;;

let rec print_lines = function
  | [] -> ()  
  | head::tail -> 
    let (lineNumber,line) = head in 
    Printf.printf "%s \n" lineNumber line;
    print_lines tail  
;;