.PHONY: all build format edit demo clean

src?=0
dst?=5
graph?=graph1.txt
bigraph?=bi_graph3.txt

all: build

build:
	@echo "\n   🚨  COMPILING  🚨 \n"
	dune build src/ftest.exe
	ls src/*.exe > /dev/null && ln -fs src/*.exe .

format:
	ocp-indent --inplace src/*

edit:
	code . -n

ford: build
	@echo "\n   ⚡  EXECUTING  ⚡\n"
	./ftest.exe 0 graphs/${graph} $(src) $(dst) outfile
	@echo "\n   🥁  RESULT (content of outfile)  🥁\n"
	@cat outfile

bipartite: build
	@echo "\n   ⚡  EXECUTING  ⚡\n"
	./ftest.exe 1 bi_graphs/${bigraph} 0 1 outfile
	@echo "\n   🥁  RESULT (content of outfile)  🥁\n"
	@cat outfile

clean:
	find -L . -name "*~" -delete
	rm -f *.exe
	dune clean
