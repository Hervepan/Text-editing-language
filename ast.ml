open Printf;;

type direction =
  |Right
  |Left
;;


type move =
  |Home
  |End
  |Wordmove of int * direction
;;

type execute =
  |Delete
  |Copy
  |Paste
;;

type command =
  |Move of move
  |Execute of execute
  |Full_command of execute * move
  |Insert of string
  |Substitute of string * string 
;;

type line_command =
  |Line_command of int * (command list)
;;

let line_to_str = function 
  |(-2) -> "On all the lines " 
  |(-1) -> "On last line "
  |num -> "On line " ^ string_of_int num
;;

let execute_to_str = function 
  |Delete -> "Delete"
  |Copy -> "Copy"
  |Paste -> "Paste"
;;

let move_to_str = function 
  |Home -> "to the start of the line"
  |End -> "to the end of the line"
  |Wordmove(number,direction) -> 
    match direction with 
    |Right -> string_of_int number ^ " words to the right"
    |Left -> string_of_int number ^ " words to the left"
;;


let print_command = function 
  |Insert(str)->
    Printf.printf "\tInsert \"%s\"\n" str 
  |Execute(execute) -> 
    let execute_str = execute_to_str execute in 
      Printf.printf "\t%s the line\n" execute_str 
  |Move(move)-> 
    let move_str = move_to_str move in 
      Printf.printf "\tMove %s\n" move_str
  |Full_command(execute,move) -> 
    let execute_str = execute_to_str execute in 
      let move_str = move_to_str move in 
        Printf.printf "\t%s %s\n" execute_str move_str 
  |Substitute(pattern,replacement) -> 
    Printf.printf "\tSubstitute %s for %s\n" pattern replacement 
;;

let rec print_commands = function
  |[] -> ()
  |command::commands -> 
      print_command command;
      print_commands commands
;;

let print_linecommand = function  
  |Line_command(line,commands) -> 
    let line_str = line_to_str line in 
      Printf.printf "%s \n" line_str ;
      print_commands(commands)
;;

let rec print_linecommands = function
  |[] -> ()
  |lcommand::lcommands -> 
      print_linecommand lcommand;
      print_linecommands lcommands
;;