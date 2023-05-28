%{
  open Ast
%}

%token <int> INT
%token <string> STRING
%token COLON SEMICOLON BOTTOM GLOBAL INSERT SUBTITUTE COMMA 
%token <Ast.execute> EXECUTE
%token <Ast.move> MOVE
%token <Ast.direction> DIRECTION

%start main
%type <Ast.line_command list> main

%%
main:
  line_commands SEMICOLON SEMICOLON{$1}

line_commands: 
  line_command {[$1]}
  |line_commands SEMICOLON line_command {$1@[$3]}

line_command: 
  line commands {Line_command($1,$2)}

commands:
  command {[$1]}
  |commands COMMA command {$1@[$3]}

command:
  INSERT STRING {Insert($2)}
  |EXECUTE {Execute($1)}
  |moves {Move($1)}
  |EXECUTE moves {Full_command($1,$2)}
  |SUBTITUTE STRING STRING {Substitute($2,$3)}

line : 
  INT COLON { $1 }

moves :
  MOVE {$1}
  |INT DIRECTION {Wordmove($1,$2)}



