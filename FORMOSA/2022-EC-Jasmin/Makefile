JASMINC = jasminc  # point to your jasminc
EASYCRYPT = easycrypt # point to your easycrypt
GCC = gcc 
# if on Apple M1 use GCC = arch -x86_64 gcc

EE = extraction/example
AE = extraction/aeslib
EB = build/example
AB = build/aeslib
EP = proof/example
AP = proof/aeslib
TT = test

INCL = -I AES:src/aeslib
INCLT = -I AES:../../src/aeslib

OUT_DIR = build build/temp $(AB) $(EB) $(EE) $(AE)

.PHONY: dirs

all: all_source $(AB)/test_aes $(EB)/test_NbAESEnc $(EB)/test_NbAESEnc_mem

all_source: dirs \
	  $(AE)/AES_jazz.ec $(AE)/AES_jazz_ct.ec \
          $(EE)/NbAESEnc_jazz.ec $(EE)/NbAESEnc_jazz_ct.ec \
          $(EE)/NbAESEnc_mem_jazz.ec $(EE)/NbAESEnc_mem_jazz_ct.ec \

# BUILD AES LIB

$(AB)/aes.s: src/aeslib/aes.jazz src/aeslib/aes.jinc dirs
	$(JASMINC) $(INCL) src/aeslib/aes.jazz -o $(AB)/aes.s

# EXTRACT AES LIB FOR CORRECTNESS/SECURITY

$(AE)/AES_jazz.ec: src/aeslib/aes.jazz src/aeslib/aes.jinc dirs
	cd build/temp && rm -f *.ec && \
    $(JASMINC) $(INCLT) ../../src/aeslib/aes.jazz -ec aes -ec invaes -oec AES_jazz.ec
	mv build/temp/*.ec $(AE)

# EXTRACT AES LIB FOR CONSTANT-TIME

$(AE)/AES_jazz_ct.ec: src/aeslib/aes.jazz src/aeslib/aes.jinc dirs
	cd build/temp && rm -f *.ec && \
	  $(JASMINC) $(INCLT) ../../src/aeslib/aes.jazz -CT -ec aes -ec invaes -oec AES_jazz_ct.ec
	mv build/temp/*.ec $(AE)

# BUILD NbAESEnc WITH REGISTER CALLING CONVENTION

$(EB)/NbAESEnc.s: src/example/NbAESEnc.jazz src/aeslib/aes.jazz src/aeslib/aes.jinc dirs
	$(JASMINC) $(INCL) src/example/NbAESEnc.jazz -o $(EB)/NbAESEnc.s

# EXTRACT NbAESEnc WITH REGISTER CALLING CONVENTION FOR CORRECTNESS/SECURITY

$(EE)/NbAESEnc_jazz.ec: src/example/NbAESEnc.jazz src/aeslib/aes.jazz src/aeslib/aes.jinc  dirs
	cd build/temp && rm -f *.ec && \
	  $(JASMINC) $(INCLT) ../../src/example/NbAESEnc.jazz -ec enc -ec dec -oec NbAESEnc_jazz.ec
	mv build/temp/*.ec $(EE)

# EXTRACT NbAESEnc WITH REGISTER CALLING CONVENTION FOR CONSTANT-TIME

$(EE)/NbAESEnc_jazz_ct.ec: src/example/NbAESEnc.jazz src/aeslib/aes.jazz src/aeslib/aes.jinc  dirs
	cd build/temp && rm -f *.ec && \
	  $(JASMINC) $(INCLT) ../../src/example/NbAESEnc.jazz -CT -ec enc -ec dec -oec NbAESEnc_jazz_ct.ec
	mv build/temp/*.ec $(EE)

# BUILD NbAESEnc WITH MEMORY CALLING CONVENTION

$(EB)/NbAESEnc_mem.s: src/example/NbAESEnc_mem.jazz src/aeslib/aes.jazz src/aeslib/aes.jinc  dirs
	$(JASMINC) $(INCL) src/example/NbAESEnc_mem.jazz -o $(EB)/NbAESEnc_mem.s

# EXTRACT NbAESEnc WITH MEMORY CALLING CONVENTION FOR CORRECTNESS/SECURITY

$(EE)/NbAESEnc_mem_jazz.ec: src/example/NbAESEnc_mem.jazz src/aeslib/aes.jazz src/aeslib/aes.jinc  dirs
	cd build/temp && rm -rf *.ec && \
	  $(JASMINC)  $(INCLT) ../../src/example/NbAESEnc_mem.jazz -ec enc -ec dec -oec NbAESEnc_mem_jazz.ec
	mv build/temp/*.ec $(EE)

# EXTRACT NbAESEnc WITH MEMORY CALLING CONVENTION FOR CONSTANT-TIME

$(EE)/NbAESEnc_mem_jazz_ct.ec: src/example/NbAESEnc_mem.jazz src/aeslib/aes.jazz src/aeslib/aes.jinc dirs
	cd build/temp && rm -rf *.ec && \
	   $(JASMINC)  $(INCLT) ../../src/example/NbAESEnc_mem.jazz -CT -ec enc -ec dec -oec NbAESEnc_mem_jazz_ct.ec
	mv build/temp/*.ec $(EE)

# BUILD TESTS

$(AB)/test_aes: $(AB)/aes.s $(TT)/test_aes.c dirs
	$(GCC) -Wall $(AB)/aes.s $(TT)/test_aes.c \
	    -o $(AB)/test_aes

$(EB)/test_NbAESEnc: $(TT)/test_NbAESEnc.c $(EB)/NbAESEnc.s dirs
	$(GCC) -msse4.1 -Wall $(EB)/NbAESEnc.s $(TT)/test_NbAESEnc.c \
	    -o $(EB)/test_NbAESEnc

$(EB)/test_NbAESEnc_mem: $(TT)/test_NbAESEnc_mem.c $(EB)/NbAESEnc_mem.s dirs
	$(GCC) -Wall $(EB)/NbAESEnc_mem.s $(TT)/test_NbAESEnc_mem.c \
	    -o $(EB)/test_NbAESEnc_mem

test: all
	@echo
	@echo '************************************************'
	@echo '***        Testing AES implementation        ***'
	@echo '************************************************'
	$(AB)/test_aes
	@echo
	@echo '************************************************'
	@echo '*** Testing encryption scheme (reg cc)      *** '
	@echo '************************************************'
	$(EB)/test_NbAESEnc
	@echo
	@echo '************************************************'
	@echo '*** Testing encryption scheme (mem cc)      *** '
	@echo '************************************************'
	$(EB)/test_NbAESEnc_mem

safety: 
	@echo
	@echo '************************************************'
	@echo '***    Safety checking AES implementation    ***'
	@echo '************************************************'
	$(JASMINC) $(INCL) -checksafety src/aeslib/aes.jazz
	@echo
	@echo '************************************************'
	@echo '***Safety checking encryption scheme (reg cc)***'
	@echo '************************************************'
	$(JASMINC) $(INCL)  -checksafety src/example/NbAESEnc.jazz
	@echo
	@echo '************************************************'
	@echo '***Safety checking encryption scheme (mem cc)***'
	@echo '************************************************'
	$(JASMINC) $(INCL) -checksafety src/example/NbAESEnc_mem.jazz

proofs: all_source
	@echo
	@echo '************************************************'
	@echo '***        Machine-checking AES proof        ***'
	@echo '************************************************'
	for f in $(AP)/*.ec; do echo $$f; \
	    $(EASYCRYPT) compile $$f -I $(AE); done
	@echo
	@echo '************************************************'
	@echo '*** Machine-checking encryption scheme proof ***'
	@echo '************************************************'
	for f in proof/example/*.eca; do echo $$f; \
	    $(EASYCRYPT) compile $$f -I $(AE) -I $(EE) -I $(AP); done
	for f in proof/example/*.ec; do echo $$f; \
	    $(EASYCRYPT) compile $$f -I $(AE) -I $(EE) -I $(AP); done

check: test safety proofs

clean: 
	rm -Rf $(AE)/* $(EE)/* build
	rm -f $(AP)/*.eco  
	rm -f $(EP)/*.eco
	rm -f $(EXP)/*.eco 

dirs: ${OUT_DIR}

${OUT_DIR}:
	mkdir -p ${OUT_DIR}

