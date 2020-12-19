run: aslib.so ffi-test.rkt run_as_ctorbin.exe run_as_bin.exe run_as_lib.exe
	@echo running ocaml binary
	./run_as_bin.exe
	@echo running ocaml binary with ctor attr
	./run_as_ctorbin.exe
	@echo running ocaml binary via lib
	./run_as_lib.exe
	@echo running via racket with GC disabled
	env PLTDISABLEGC=1 racket ffi-test.rkt
	@echo running via racket with GC enabled
	racket ffi-test.rkt

doubler.cmx: doubler.ml
	ocamlopt -fPIC -g -c $<

prog.o: doubler.cmx
	ocamlopt -fPIC -g -output-obj -o $@ $<

main.o: main.c
	cc -fPIC -g -I`ocamlc -where` -c $<

main_ctor.o: main_ctor.c
	cc -fPIC -g -I`ocamlc -where` -c $<

main_lib.o: main_lib.c
	cc -fPIC -g -I`ocamlc -where` -c $<

aslib.o: aslib.c
	cc -fPIC -g -I`ocamlc -where` -c $<

run_as_bin.exe: prog.o main.o
	cc -fPIC -g -o $@ $^ -L`ocamlc -where` -lasmrun_pic -lm -ldl

run_as_ctorbin.exe: prog.o main_ctor.o
	cc -fPIC -g -o $@ $^ -L`ocamlc -where` -lasmrun_pic -lm -ldl

run_as_lib.exe: prog.o aslib.o main_lib.o
	cc -fPIC -g -o $@ $^ -L`ocamlc -where` -lasmrun_pic -lm -ldl
	
aslib.so: aslib.o prog.o
	cc -fPIC -o $@ $^ -shared -L`ocamlc -where` -lasmrun_pic -lm -ldl

clean:
	rm -f *.o *.so *.cmx *.exe *.cmi
