require import AllCore SmtMap List Distr.
require (****) PRFth NbENc.

clone include NbEnc with
   type ct = pt,
   op used_nonce = (fun n (nonces:nonce list) => n \in nonces).

(* We get the syntax and security definitions for nonce-based
   encryption by copying all the defiinitoins in NbEnc with
   some renamings. *)

print CPA.

clone include PRFth with
   type key     <- key,
   type input   <- nonce,
   type output  <- ct,
   op   doutput <- dct,
   op   q       <- q.

print f.
print RF.
