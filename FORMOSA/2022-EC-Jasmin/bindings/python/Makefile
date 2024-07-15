.SUFFIXES: .s .so

ASM := ../../build/example/NbAESEnc_mem.s

all: test.py libNbAES.so
	python3 $<

libNbAES.so: $(ASM)
	cc -shared -o $@ $^

clean:
	$(RM) *.so
