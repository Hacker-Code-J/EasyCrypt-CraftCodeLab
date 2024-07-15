all: test
	./test

clean:
	$(RM) *.a *.o test

libNbAES.a:
	cc -c -o aeslib.o ../../build/aeslib/aes.s
	cc -c -o NbAES.o ../../build/example/NbAESEnc_mem.s
	ar rv libNbAES.a aeslib.o NbAES.o

test: libNbAES.a
	rustc -C opt-level=3 -L. test.rs
