module type Challenger = {
    proc encrypt(m:msg): cip
    proc decrypt(c:cip): msg
}.

module C:Challenger = {
    proc encrypt(m:msg): cip = {
        return enc(m);
    }   
    proc decrypt(c:cip): msg = {
        return dec(c);
    }
}.

(* Similarly, we define an adversary *)
module type Adversary = {
    proc guess(c:cip): bool
}.

(* and a concrete instance of an adversary *)
module Adv:Adversary = {
    proc guess(c:cip): bool = {
        return comp(c);
    }
}.
