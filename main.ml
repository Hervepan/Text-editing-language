let main() =
  let filename = 
    match Array.length Sys.argv with
    |1-> Printf.eprintf "Missing the name of the file that you want to edit\n"; exit 0
    |2-> Sys.argv.(1)
    |_-> Printf.eprintf "Too much argument on the command line\n"; exit 0
  in
  let lexbuf = Lexing.from_channel stdin in
  let ast = Parser.main Lexer.read_token lexbuf in
  let last = Evaluate.lastline filename in 
  let updated_ast = Evaluate.expand_ast last ast in
  let lineNumbers = Evaluate.get_linenumber last updated_ast in 
  let lineToEdit = Evaluate.lineToEdit filename lineNumbers in 
  let editedLine =  Evaluate.evaluate_ast lineToEdit updated_ast [] in
    Evaluate.print_lines editedLine;
    Printf.printf "\n" ;
;;

if !Sys.interactive then () else main();;
