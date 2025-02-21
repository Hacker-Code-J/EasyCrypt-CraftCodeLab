type msg.
type cip.

(* Encrypt and decrypt operations *)
op enc: msg -> cip.
op dec: cip -> msg.

(* Compute operations for the adversary *)
op comp: cip -> bool.
