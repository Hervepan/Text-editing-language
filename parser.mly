%{
  open Ast
%}

%token <int> INT
%token <string> STRING
%token COLON SEMICOLON
%token BOTTOM GLOBAL 
%token <Ast.move> MOVE
%token <Ast.direction> DIRECTION
%token INSERT SUBTITUTE
%token <Ast.execute> EXECUTE
%token EOL

%start main
%type <Ast.line_commands list> main

%%
main:
  line_command EOL {$1}
  |line_commands {$1}

line_commands: 
  line_command  {$1}
  |line_commands EOL line_command {$1@$3}

line_command: 
  line commands {[Line_commands($1,$2)]}

commands:
  command {[$1]}
  |commands SEMICOLON command {$1@[$3]}

command:
  INSERT STRING {Insert($2)}
  |EXECUTE {Execute($1)}
  |moves {Move($1)}
  |EXECUTE moves {Full_command($1,$2)}
  |SUBTITUTE STRING STRING {Substitute($2,$3)}

line : 
  INT COLON { Linenumber($1)}
  |GLOBAL COLON { Global }
  |BOTTOM COLON { Bottom }

moves :
  MOVE {$1}
  |INT DIRECTION {Wordmove($1,$2)}



