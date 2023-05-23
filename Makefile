LEXER = lexer
PARSER = parser
MAIN = main
AST = ast

.PHONY: all clean

all: $(MAIN)

$(LEXER).ml : $(LEXER).mll $(AST).cmi
	ocamllex $<

$(PARSER).mli $(PARSER).ml : $(PARSER).mly
	ocamlyacc $<

$(PARSER).cmi : $(PARSER).mli
	ocamlc -c $<

$(PARSER).cmo : $(PARSER).ml $(AST).cmi $(PARSER).cmi
	ocamlc -c $<

%.cmi %.cmo : %.ml
	ocamlc -c $<

$(MAIN): $(AST).cmo $(PARSER).cmo  $(LEXER).cmo  $(MAIN).cmo 
	ocamlc -o $@ $^

clean:
	rm -f $(LEXER).ml $(PARSER).ml $(PARSER).mli *.cmi *.cmo $(MAIN)

reconstruct: 
	make clean 
	make all