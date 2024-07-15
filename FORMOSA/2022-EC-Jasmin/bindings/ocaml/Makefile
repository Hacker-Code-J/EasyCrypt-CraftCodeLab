all: test
	./test

test: NbAES.o test.ml
	ocamlfind opt -thread -package ctypes.foreign -linkpkg -o $@ $^

NbAES.o: ../../build/example/NbAESEnc_mem.s
	cc -c -o $@ $^

clean:
	$(RM) *.cmi *.cmx *.o test
