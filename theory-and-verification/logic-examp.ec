(* logic-examp.ec *)

require import AllCore.  (* core theories *)

(* here's a lemma for learning some simple Ambient Logic
   proof techniques; in fact, it's already in EasyCrypt's
   library with the same name; and smt() will prove it *)

lemma negb_or (a b : bool) :
  !(a \/ b) <=> !a /\ !b.
proof.
split.
move => not_or.
split.
case a.
move => a_true.
have contrad : a \/ b.
   left.
   trivial.
trivial.
trivial.
case b.
move => b_true.
simplify.
have contrd: a \/ b.
   right.
   trivial.
trivial.
trivial.
move => and_not.
elim and_not => a_false b_false.
case (a \/ b).
move => or.
elim or.
trivial.
trivial.
trivial.
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
