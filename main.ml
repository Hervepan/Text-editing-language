(* File calc.ml *)
let _ =
  try
    let lexbuf = Lexing.from_channel stdin in
    while true do
      let result = Parser.main Lexer.read_token lexbuf in
        Ast.print_linecommands result; print_endline ""; flush stdout
    done
  with Lexer.Eof ->
    exit 0
