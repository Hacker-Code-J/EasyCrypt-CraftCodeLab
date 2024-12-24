require import AllCore Distr List.
from Jasmin require import JModel.
require import Array11 AES_jazz NbAESEnc_jazz_ct NbAESEnc_jazz AES_spec AES_proof NbAESEnc_ct_proof.
require (*  *) NbPRFEnc.

(* We refine our nonce-based encryption scheme by creating our own
   local copy of the theory and instantiating the PRF types and
   algorithm with those of an AES operator that defines the semantics
   of aes in Jasmin.

   In general there could be an abstraction gap between the types used
   by the refined scheme that we proved secure (e.g., ZModP) and the
   Jasmin representation of values in those types (e.g., W128.t).
   In this case, preconditions/post-conditions assume/require
   that the inputs/outputs to/of the Jasmin implementation are
   correct representations of the refined scheme inputs/outputs.
   Here representation is just equality. *)

type key = W128.t.
type plaintext = W128.t.
type nonce = W128.t.

(* W128.dword is the uniform distribution over word of size 128 bits *)
op dkey = W128.dword.
op dciphertext = W128.dword.

clone import NbPRFEnc as RefinedScheme with
  type key         <- key,
  type nonce       <- nonce,
  type plaintext   <- plaintext,
  op   f           <- aes,
  op   dkey        <- dkey,
  op   dciphertext <- dciphertext,
  op   dflt        <- W128.zero,
  op   (^)         <- W128.(+^),
  type leakages    <- leakages_t
  proof *.

realize dciphertext_ll by apply W128.dword_ll.
realize dciphertext_uni by apply W128.dword_uni.
realize dciphertext_full by apply W128.dword_fu.
realize xor_idempotent1 by smt(@W128).
realize xor_idempotent2 by smt(@W128).

(*
print Scheme.
print indcpa_security.
*)

(* Our library for AES includes a proof that extracted Jasmin code
   for the AES function (AES_jass.M, which calls the AES-NI instructions) is
   computing the aes operator that defines our reference AES
   semantics. We first prove that our NbAESEncryption scheme is
   actually using the exact same Jasmin implementation, and
   derive as a corollary that M.aes computes the aes operator.  *)

equiv aes_correct_E :
  NbAESEnc_jazz.M.aes ~ AES_jazz.M.aes :
    ={arg} ==> ={res} by sim.

phoare aes_correct k n : [NbAESEnc_jazz.M.aes : arg = (k,n) ==> res  = aes k n] = 1%r.
proof. conseq aes_correct_E (aes_jazz_correct k n) => /#. qed.

(* With the above results as helpers, we can prove that our
   Jasmin code is correct with respect to the specification.
   We do this in two steps: first we prove equivalence to
   the scheme and then we derive correctness with respect
   to the encryption operator. *)
equiv enc_correct_equiv :
  NbAESEnc_jazz.M.enc ~ RefinedScheme.Scheme.enc :  ={arg} ==> ={res}.
proof.
proc.
inline M.xor; wp.
by ecall {1} (aes_correct k{1} n{1}).
qed.

(* Then we derive correctness as a corollary. *)
phoare enc_correct _k _n _p :
 [ NbAESEnc_jazz.M.enc :
    arg = (_k,_n,_p) ==> res = enc _k _n _p ] = 1%r.
proof.
  conseq (enc_correct_equiv) (correct_enc _k _n _p) => /#.
qed.

(* We do the same for decryption *)
equiv dec_correct_equiv :
  NbAESEnc_jazz.M.dec ~ RefinedScheme.Scheme.dec :  ={arg} ==> ={res}.
proof.
proc.
inline M.xor; wp.
by ecall {1} (aes_correct k{1} n{1}).
qed.

phoare dec_correct _k _n _c :
 [ NbAESEnc_jazz.M.dec :
    arg = (_k,_n,_c) ==> res = dec _k _n _c ] = 1%r.
proof.
  conseq (dec_correct_equiv) (correct_dec _k _n _c)  => /#.
qed.

(* These results show each of our Jasmin procedures
   are implemementing the encryption and decryption
   operators correctly. But can we conclude that they
   constitute a correct and secure encryption scheme? *)

(* For that we need to put them together into the
   Scheme syntax, assuming keys are generated as
   per the specification. *)

module ConcreteScheme = {
  include Scheme [ kg ]
  include M [enc, dec]
}.

(* Now  we can use the correctness of the implementation
   and propagate specification correctness to implementation
   correctness. *)

lemma concrete_correctness &m (_k _n _p : W128.t):
    Pr[Correctness(ConcreteScheme).main(_k, _n, _p) @ &m : res] = 1%r.
proof.
rewrite (_: 1%r = Pr[Correctness(Scheme).main(_k, _n, _p) @ &m : res]);
   first by rewrite -(correctness &m _k _n _p).
byequiv; last 2 by done.
proc.
by call (dec_correct_equiv); call (enc_correct_equiv).
qed.

section.

declare module A <: AdvCPA { -RF, -RealPRF, -RealScheme, -WO, -Count}.

lemma concrete_indcpa_security &m:
   (* Advantages match *)
  `| Pr[CPA(A,RealScheme(ConcreteScheme)).main() @ &m : res] -
       Pr[CPA(A,IdealScheme).main() @ &m : res]| =
  `| Pr[PRF(B(A), RealPRF).main() @ &m : res] -
       Pr[PRF(B(A), RF).main() @ &m : res] |.
proof.
rewrite -(indcpa_security A &m).
have -> // : Pr[CPA(A, RealScheme(ConcreteScheme)).main() @ &m : res] =
             Pr[CPA(A, RealScheme(Scheme)).main() @ &m : res].
byequiv => //.
proc.
call(_: ={RealScheme.k,WO.nonces}); last by inline *; auto => />.
proc.
sp; if; 1,3: by auto.
wp;call(_: ={RealScheme.k}); last by auto.
call (enc_correct_equiv); auto.
qed.

end section.


(* ----------------------------------------------------------------------------- *)
(* We now prove the same kind of result considering timing leakage. For that we
   use the alternative file _ct that was extracted for explicit leakage 
   construction. *)

(* Here is the scheme with leakage, leveraging the constant-time
   extraction. *)
module ConcreteLScheme = {
  include Scheme [ kg ]

  proc enc (k:key, n:nonce, p:plaintext) = {
    var c;
    NbAESEnc_jazz_ct.M.leakages <- [];
    c <@  NbAESEnc_jazz_ct.M.enc(k,n,p);
    return (c, NbAESEnc_jazz_ct.M.leakages);
  }

  proc dec (k:key, n:nonce, c:ciphertext) = {
    var p;
    NbAESEnc_jazz_ct.M.leakages <- [];
    p <@  NbAESEnc_jazz_ct.M.dec(k,n,c);
    return (c, NbAESEnc_jazz_ct.M.leakages);
  }

}.

(* Recall that we proved that enctryption is constant-time! *)
(* print enc_ct. *)

(* Our scheme with leakage has identical outputs to the one above, which
   allows us to derive the functional correctness results we need. *)
equiv eq_leak : ConcreteLScheme.enc ~ NbAESEnc_jazz.M.enc : ={arg} ==> res{1}.`1 = res{2}.
proof. by proc; inline {1} 2; wp; conseq />; sim => /#.  qed.

lemma enc_fc _k _n _p : phoare [ ConcreteLScheme.enc : arg = (_k,_n,_p) ==> res.`1 = enc _k _n _p ] = 1%r.
proof. by conseq (eq_leak) (enc_correct _k _n _p) => /#. qed.

module Si = SimLeak(ConcreteLScheme).

lemma concrete_indlcpa_security
  (A <: AdvLCPA { -WO, -RealScheme, -NbAESEnc_jazz_ct.M, -BL, -RF, -RealPRF, -Count})
  &m :
  `|Pr[LCPA(A, RealLScheme(ConcreteLScheme)).main() @ &m : res] -
      Pr[LCPA(A, IdealLScheme(Si)).main() @ &m : res]| =
  `|Pr[PRF(BBL(A, Si), RealPRF).main() @ &m : res] -
      Pr[PRF(BBL(A, Si), RF).main() @ &m : res]|.
proof. 
apply (indlcpa_security ConcreteLScheme _ _ _ A &m).
(* Key generation is correct *)
+ by sim.
(* Encryption is correct *)
+ by move => _k _n _p;  proc*; call (enc_fc _k _n _p). 
(* Encryption is constant time *)
+ by proc; call enc_ct; auto => />.
qed.





