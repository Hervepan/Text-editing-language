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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
  open Ast
# 20 "parser.ml"
let yytransl_const = [|
  259 (* COLON *);
  260 (* SEMICOLON *);
  261 (* BOTTOM *);
  262 (* GLOBAL *);
  263 (* INSERT *);
  264 (* SUBTITUTE *);
  265 (* COMMA *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* STRING *);
  266 (* EXECUTE *);
  267 (* MOVE *);
  268 (* DIRECTION *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\005\000\005\000\006\000\006\000\
\006\000\006\000\006\000\004\000\007\000\007\000\000\000"

let yylen = "\002\000\
\003\000\001\000\003\000\002\000\001\000\003\000\002\000\001\000\
\001\000\002\000\003\000\002\000\001\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\015\000\000\000\002\000\000\000\012\000\
\000\000\000\000\000\000\000\000\000\000\013\000\000\000\005\000\
\009\000\001\000\003\000\014\000\007\000\000\000\010\000\000\000\
\011\000\006\000"

let yydgoto = "\002\000\
\004\000\005\000\006\000\007\000\015\000\016\000\017\000"

let yysindex = "\002\000\
\003\255\000\000\009\255\000\000\010\255\000\000\255\254\000\000\
\001\255\005\255\013\255\014\255\000\255\000\000\011\255\000\000\
\000\000\000\000\000\000\000\000\000\000\016\255\000\000\255\254\
\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\004\255\000\000\015\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\012\000\000\000\000\000\254\255\010\000"

let yytablesize = 23
let yytable = "\010\000\
\010\000\003\000\001\000\003\000\018\000\011\000\012\000\008\000\
\013\000\014\000\014\000\008\000\008\000\009\000\021\000\022\000\
\020\000\025\000\004\000\024\000\019\000\026\000\023\000"

let yycheck = "\001\001\
\001\001\001\001\001\000\001\001\004\001\007\001\008\001\004\001\
\010\001\011\001\011\001\003\001\009\001\004\001\002\001\002\001\
\012\001\002\001\004\001\009\001\009\000\024\000\013\000"

let yynames_const = "\
  COLON\000\
  SEMICOLON\000\
  BOTTOM\000\
  GLOBAL\000\
  INSERT\000\
  SUBTITUTE\000\
  COMMA\000\
  "

let yynames_block = "\
  INT\000\
  STRING\000\
  EXECUTE\000\
  MOVE\000\
  DIRECTION\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'line_commands) in
    Obj.repr(
# 17 "parser.mly"
                                   (_1)
# 107 "parser.ml"
               : Ast.line_command list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'line_command) in
    Obj.repr(
# 20 "parser.mly"
               ([_1])
# 114 "parser.ml"
               : 'line_commands))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'line_commands) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'line_command) in
    Obj.repr(
# 21 "parser.mly"
                                        (_1@[_3])
# 122 "parser.ml"
               : 'line_commands))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'line) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'commands) in
    Obj.repr(
# 24 "parser.mly"
                (Line_command(_1,_2))
# 130 "parser.ml"
               : 'line_command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'command) in
    Obj.repr(
# 27 "parser.mly"
          ([_1])
# 137 "parser.ml"
               : 'commands))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'commands) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'command) in
    Obj.repr(
# 28 "parser.mly"
                          (_1@[_3])
# 145 "parser.ml"
               : 'commands))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 31 "parser.mly"
                (Insert(_2))
# 152 "parser.ml"
               : 'command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Ast.execute) in
    Obj.repr(
# 32 "parser.mly"
           (Execute(_1))
# 159 "parser.ml"
               : 'command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'moves) in
    Obj.repr(
# 33 "parser.mly"
         (Move(_1))
# 166 "parser.ml"
               : 'command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Ast.execute) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'moves) in
    Obj.repr(
# 34 "parser.mly"
                 (Full_command(_1,_2))
# 174 "parser.ml"
               : 'command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 35 "parser.mly"
                           (Substitute(_2,_3))
# 182 "parser.ml"
               : 'command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : int) in
    Obj.repr(
# 38 "parser.mly"
            ( _1 )
# 189 "parser.ml"
               : 'line))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Ast.move) in
    Obj.repr(
# 41 "parser.mly"
       (_1)
# 196 "parser.ml"
               : 'moves))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : int) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Ast.direction) in
    Obj.repr(
# 42 "parser.mly"
                 (Wordmove(_1,_2))
# 204 "parser.ml"
               : 'moves))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.line_command list)
