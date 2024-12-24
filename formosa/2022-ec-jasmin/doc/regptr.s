###########################################################
# read this file from "bottom to top", starting at label 'L_xor1$1:',
# which corresponds to 'function fn _xor1(reg ptr u64[P1] p) -> reg u64'
# then move to "L_xor2$1:", then "_export1:", ...
###########################################################

  .att_syntax
  .text
  .p2align  5
  .globl  _export5
  .globl  export5
  .globl  _export4
  .globl  export4
  .globl  _export3
  .globl  export3
  .globl  _export2
  .globl  export2
  .globl  _export1
  .globl  export1

###########################################################
_export5:
export5:
  movq  %rsp, %r10
  andq  $-8, %rsp
  leaq  glob_data + 0(%rip), %rax      # in here is it possible to observe global variable being used 
  leaq  -128(%rsp), %rsp
  leaq  Lexport5$1(%rip), %rsi
  jmp   L_xor1$1
Lexport5$1:
  leaq  128(%rsp), %rsp
  movq  %r10, %rsp
  ret 

###########################################################
_export4:
export4:
  movq  %rsp, %r10
  leaq  -256(%rsp), %rsp
  andq  $-8, %rsp
  movq  $0, %rax
  jmp   Lexport4$3
Lexport4$4:
  movq  %rax, (%rsp,%rax,8)
  incq  %rax
Lexport4$3:
  cmpq  $32, %rax
  jb    Lexport4$4
  leaq  128(%rsp), %rax
  leaq  -128(%rsp), %rsp
  leaq  Lexport4$2(%rip), %rsi
  jmp   L_xor1$1
Lexport4$2:
  leaq  128(%rsp), %rsp
  movq  %rsp, %rcx
  leaq  -256(%rsp), %rsp
  leaq  Lexport4$1(%rip), %rdi
  jmp   L_xor2$1
Lexport4$1:
  leaq  256(%rsp), %rsp
  xorq  %rcx, %rax
  movq  %r10, %rsp
  ret 

###########################################################
_export3:
export3:
  movq  %rsp, %r10                # create a backup of rsp
  leaq  -384(%rsp), %rsp          # allocate some stack space (16*8 + 16*2*8)
  andq  $-8, %rsp
  movq  $0, %rax                  # init code (2 loops)
  jmp   Lexport3$5
Lexport3$6:
  movq  %rax, (%rsp,%rax,8)       # this initializes 'x', which is in rsp[0..128[
  incq  %rax
Lexport3$5:
  cmpq  $16, %rax
  jb    Lexport3$6
  movq  $0, %rax
  jmp   Lexport3$3
Lexport3$4:
  movq  %rax, 128(%rsp,%rax,8)    # this initializes 'y', which is in rsp[128..384[
  incq  %rax
Lexport3$3:
  cmpq  $32, %rax
  jb    Lexport3$4                # end of initialization of x and y

                                  ###########################################################
  movq  %rsp, %rax                # the first call is to xor1, load a pointer to 'x' into rax
  leaq  -128(%rsp), %rsp          # allocate the stack space for xor1
  leaq  Lexport3$2(%rip), %rsi    # init the return address
  jmp   L_xor1$1                  # jump to the xor1; return value is in rax 
Lexport3$2:
  leaq  128(%rsp), %rsp           # restore stack pointer
  leaq  128(%rsp), %rcx           # load y into rcx 
  leaq  -256(%rsp), %rsp          # alocate stack space for xor2; return will be in rcx as well
  leaq  Lexport3$1(%rip), %rdi
  jmp   L_xor2$1
Lexport3$1:
  leaq  256(%rsp), %rsp
  xorq  %rcx, %rax
  movq  %r10, %rsp
  ret 

###########################################################
_export2:
export2:
  movq  %rsp, %r10
  leaq  -256(%rsp), %rsp          # basically the same as export1 but for more bytes
  andq  $-8, %rsp
  movq  $0, %rax
  jmp   Lexport2$2
Lexport2$3:
  movq  %rax, (%rsp,%rax,8)
  incq  %rax
Lexport2$2:
  cmpq  $32, %rax
  jb    Lexport2$3
  movq  %rsp, %rcx
  leaq  -256(%rsp), %rsp          # allocates 256 bytes 
  leaq  Lexport2$1(%rip), %rdi
  jmp   L_xor2$1
Lexport2$1:
  leaq  256(%rsp), %rsp
  movq  %rcx, %rax
  movq  %r10, %rsp
  ret 

###########################################################
_export1:
export1:
  movq  %rsp, %r10
  leaq  -128(%rsp), %rsp          # 128 bytes allocated for this function
  andq  $-8, %rsp
  movq  $0, %rax                  # init x 
  jmp   Lexport1$2                # ...
Lexport1$3:                       # ...
  movq  %rax, (%rsp,%rax,8)       # ...
  incq  %rax                      # ...
Lexport1$2:                       # ...
  cmpq  $16, %rax                 # ...
  jb    Lexport1$3                # ...
                                  # x initialization is done

  movq  %rsp, %rax                # load the 'ptr' of export1 x
  leaq  -128(%rsp), %rsp          # allocate the stack space for xor1
  leaq  Lexport1$1(%rip), %rsi    # load the return address into rsi
  jmp   L_xor1$1                  # go to xor1
Lexport1$1:
  leaq  128(%rsp), %rsp           # restore the stack pointer
  movq  %r10, %rsp                # restore the stack pointer
                                  # this sequence could be optimized (leaq is dead code), but this is not critical
  ret 

###########################################################
L_xor2$1:                    # this function is similar to xor1
                             # interesting part is to notice that
                             # this 'x' is at rsp + 0 as well

                             # p is rcx; return is rcx;

  movq  $0, %rdx
  jmp   L_xor2$4
L_xor2$5:
  movq  (%rcx,%rdx,8), %rsi
  movq  %rsi, (%rsp,%rdx,8)
  incq  %rdx
L_xor2$4:
  cmpq  $32, %rdx
  jb    L_xor2$5
  movq  $0, %rcx
  movq  $0, %rdx
  jmp   L_xor2$2
L_xor2$3:
  xorq  (%rsp,%rdx,8), %rcx
  incq  %rdx
L_xor2$2:
  cmpq  $32, %rdx
  jb    L_xor2$3
  jmp   *%rdi

###########################################################
L_xor1$1:
  movq  $0, %rcx             # i = 0
  jmp   L_xor1$4             # goto the 'loop condition'
L_xor1$5:                    # 'loop body1'
  movq  (%rax,%rcx,8), %rdx  # rax is p; rcx is i; 8 is bc we use u64 (scaling factor);
                             # load p[i] into t

  movq  %rdx, (%rsp,%rcx,8)  # stack array 'x' is at rsp + 0
                             # store t in x[i]
  incq  %rcx                 # increment i; i += 1

L_xor1$4:                    # 'loop condition'
  cmpq  $16, %rcx            # testing i against 16 
  jb    L_xor1$5             # if i < 16 then execute the 'loop body1'

  movq  $0, %rax             # t = 0
  movq  $0, %rcx             # i = 0
  jmp   L_xor1$2             # goto the 'loop condition2'

L_xor1$3:                    # 'loop body2'
  xorq  (%rsp,%rcx,8), %rax  # xor x[i] with t
  incq  %rcx                 # inclrement i;

L_xor1$2:                    # 'loop condition2'
  cmpq  $16, %rcx            # testing i against 16 
  jb    L_xor1$3             # if i < 16 then execute the 'loop body2'
  jmp   *%rsi                # go back to the caller function

###########################################################
  .data
  .p2align  5
_glob_data:
glob_data:
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 1
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 2
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 3
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 4
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 5
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 6
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 7
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 8
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 9
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 10
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 11
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 12
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 13
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 14
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 15
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
      .byte 0
