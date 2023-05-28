type token =
  | INT of (int)
  | STRING of (string)
  | COLON
  | SEMICOLON
  | BOTTOM
  | GLOBAL
  | INSERT
  | SUBTITUTE
  | COMMA
  | EXECUTE of (Ast.execute)
  | MOVE of (Ast.move)
  | DIRECTION of (Ast.direction)

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.line_command list
