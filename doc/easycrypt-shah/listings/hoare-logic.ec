require import AllCore.

module Func1 = {
  proc add_1 (x: int) : int = { return x + 1; }
  proc add_2 (x: int) : int = { x <- x + 2; return x; }
}.

lemma triple1: hoare [ Func1.add_1 : x = 1 ==> res = 2].
proof.
  proc.
  skip.
  move => &m H1. (* &m moves memory to the environment *)
  subst. (* Substitutes variables from the assumptions *)
  trivial.
qed.
