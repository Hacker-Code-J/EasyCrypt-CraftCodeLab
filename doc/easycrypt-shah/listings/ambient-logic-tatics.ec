require import Int.
pragma Goals: printall.

lemma int_refl: forall (n: int), n = n.
proof.
  trivial.
qed.

lemma nineteen_equal: 19 = 19.
proof.
  apply int_refl.
qed.

lemma x_plus_comm (x: int): x + 2*3 = 6 + x.
proof.
  simplify.
  (* EC does the mathematical computation for us and simplifies the goal *)
  simplify.
  (* simplify doesn't fail, and leaves the goal unchanged *)
  trivial.
  (* trivial doesn't fail either, and leaves the goal unchanged *)
  apply addzC.
  (* Discharges the goal *)
qed.

lemma x_pos (x: int): 0 < x => 0 < x+1.
proof.
  move => x_ge0.
  rewrite addz_gt0.
  (*
  "rewrite" simply rewrites the pattern provided, so in our case it
  rewrites our goal here (0 < x + 1), with the pattern that we provided
  which is addz_gt0, and then requires us to prove the assumptions of
  the pattern which are 0 < x and 0 < 1.
  *)
    (* Goal 1: 0 < x *)
    assumption.
    (* Goal 2: 0 < 1 *)
    trivial.
qed.

lemma int_assoc_rev (x y z: int): x + y + z = x + (y + z).
proof.
  print addzA.
  rewrite -addzA.
  trivial.
qed.

print op (+).
(* abbrev (+) : int -> int -> int = CoreInt.add. *)
print op min.
(* op min (a b : int) : int = if a < b then a else b. *)
print axiom Int.fold0.
(* lemma fold0 ['a]: forall (f : 'a -> 'a) (a : 'a), fold f a 0 = a. *)

search [-].
search (+).
search ( * ).

search min.
(* Shows lemmas and axioms that include the operator "min". *)

search (+) (=) (=>).
(* Shows lemmas and axioms which have all the listed operators. *)

lemma exp_prod (x: real) (a b: int): 
  x^(a*b) = x ^ a ^ b.
proof.
  search (^) ( * ) (=).
  by apply RField.exprM.
qed.

lemma exp_prod2 (x: real) (a b: int): 
  x <> 0%r 
  => x^a * x^b = x^(a + b).
proof.
  move => x_pos.
  search (^) (=).
  print  RField.exprD.
  rewrite -RField.exprD.
    assumption.
  trivial.
qed.

lemma exp_prod_smt (x: real) (a b: int): x^(a*b) = x ^ a ^ b.
proof.
  smt.
qed.

lemma exp_prod2_smt (x: real) (a b: int): x <> 0%r => x^a * x^b = x^(a + b).
proof.
  smt.
qed.


