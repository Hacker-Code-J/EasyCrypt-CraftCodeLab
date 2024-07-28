(* logic-examp.ec *)

require import AllCore.  (* core theories *)

(* here's a lemma for learning some simple Ambient Logic
   proof techniques; in fact, it's already in EasyCrypt's
   library with the same name; and smt() will prove it *)

lemma negb_or (a b : bool) :
  !(a \/ b) <=> !a /\ !b.
proof.

qed.

(* now we can use negb_or to prove: *)

lemma foo (x y z : int) :
  !(x < y \/ y < z) <=> ! x < y /\ ! y < z.
proof.

qed.

(* we can make the proof of negb_or more compact using more
   complex introduction patterns: *)

lemma negb_or' (a b : bool) :
  !(a \/ b) <=> !a /\ !b.
proof.

qed.

(* the above was nice for learning ambient techniques, but for
   these propositional logic lemmas, EasyCrypt makes it easier
   to work via case analysis - essentially via truth tables *)

lemma negb_or'' (a b : bool) :
  !(a \/ b) <=> !a /\ !b.
proof.

qed.

(* and we can tighten this up: *)

lemma negb_or''' (a b : bool) :
  !(a \/ b) <=> !a /\ !b.
proof.

qed.

(* and we could have simply used smt() *)

(* and we can tighten this up: *)

lemma negb_or'''' (a b : bool) :
  !(a \/ b) <=> !a /\ !b.
proof.

qed.
