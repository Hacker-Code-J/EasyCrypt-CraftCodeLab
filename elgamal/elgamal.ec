type group.

const q : int.
const g : group.
const k : int.
const zero : bitstring{k}.

(* require import AllCore Distr List.

type pk_t.
type sk_t.
type pt_t.
type ct_t.

op bin_uniform : bool distr.

module type Scheme = {
  proc key_gen() : pk_t * sk_t
  proc encypt(pk : pk_t, m : pt_t) : ct_t
  proc decrypt(sk : sk_t, ct : ct_t) : pt_t
}.

module type INDCPA_Adv = {
  proc gen_query(pk : pk_t) : pt_t * pt_t
  proc guess(ct : ct_t) : bool
}.

module INDCPA (S : Scheme) (A : INDCPA_Adv)  = {
  proc main() : bool = {
    var pk, sk, m0, m1, b, b', ct;
    (*var pk : pk_t;
    var sk : sk_t;
    var m0, m1 : pk_t;
    var b, b' : bool;
    var ct : ct_t;*)

    (pk, sk) <@ S.key_gen();
    (m0, m1) <@ A.gen_query(pk);
    b <$ bin_uniform;
    ct <@ S.encrypt(pk, if b then m1 else m0);
    b' <@ A.guess(ct);

    return (b = b');
  }
}. *)

(* require AllCore.

type group.
type skey = int.
type pkey = group.
type pt = group.
type ct = group * group.

const q : int.
const g : group.

print g.
print [!].
print (/\).
print (^). *)

(* op ( * ) : group group -> group = group_mult.
op ( ^ ) : group  int   -> group = group_pow.
op log : group        -> int   = group_log.

axiom q_pos : {0 < q}.
axiom group_pow_add :
  forall (x:int, y:int). {g ^ (x + y) == g ^ x + g^y}.

axiom group_pow_mult :
  forall (x:int, y:int). {(g ^ x) ^ y == g ^ (x * y)}.

axiom log_pow :
  forall (g':group). { (g ^ log(g') == g'}.

axiom pow_mod :
  forall (z:int). {g ^ (z%q) == g ^ z}. *)
