{
  open Parser        (* The type token is defined in parser.mli *)
  open Ast
  open Printf
  exception Eof
}

let digit = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z']

let int = '-'? digit+  (* regex for integers *)
let id = alpha (alpha | digit | '_')* (* regex for identifier *)
let whitespace = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"

rule read_token =
  parse
  | whitespace { read_token lexbuf }
  | ';' { SEMICOLON }
  | ':' { COLON }
  | int as value { INT(int_of_string value) }
  | id as lxm 
    { match lxm with 
        |"insert" -> INSERT
        |"BOTTOM" -> BOTTOM 
        |"GLOBAL" ->  GLOBAL 
        |"right"  -> DIRECTION(Right)
        |"left" ->  DIRECTION(Left)
        |"home" ->  MOVE(Home)
        |"end" ->  MOVE(End)
        |"delete" ->  EXECUTE(Delete)
        |"copy" ->  EXECUTE(Copy)
        |"paste" ->  EXECUTE(Paste) 
        |"sub" ->  SUBTITUTE
        |_ -> raise (Failure ("Unknow keyword " ^ lxm ^ " or you forgot to close a double quote (please refer to the documentation)")) 
    }
  | '"'      { let string = read_string (Buffer.create 20) lexbuf in STRING(string)}
  | newline { EOL }
  | eof { exit 0 }
  | _ { raise (Failure ("lexer - illegal character: " ^ Lexing.lexeme lexbuf)) }

and read_string buf = parse
  | '"' { Buffer.contents buf }
  | [^ '"' '\\']+ as s { Buffer.add_string buf s; read_string buf lexbuf }
  | _ { raise (Failure ("illegal string character: " ^ Lexing.lexeme lexbuf)) }

