require import AllCore List Distr.

(* Types for K, P, N, respectively *)
type key, ptxt, nonce.

(* Type for C *)
type ctxt = ptxt.

(* Binary infix operator on P *)
op (+) : ptxt -> ptxt -> ptxt.

(* Family of functions N -> P, indexed by k *)
op f : key -> nonce -> ptxt.

(* Sub-distribution over keys *)
op dkey : key distr.

(* Associativity, Commutativity, and
  "self-inverse" property of the binary operator,
  respectively *)
axiom addpA (x y z : ptxt) : (x + y) + z = x + (y + z).
axiom addpC (x y : ptxt) : x + y = y + x.
axiom addKp (x y : ptxt) : x + x + y = y.

module type NBEncScheme = {
  proc kgen(): key
  proc enc(k: key, n : nonce, m : ptxt): ctxt
  proc dec(k: key, n : nonce, c : ctxt): ptxt
}.

module E : NBEncScheme = {
  proc kgen() : key = {
    var k;
    k <$ dkey;
    return k;
  }

  proc enc(k : key, n : nonce, m : ptxt) : ctxt = {
    return (f k n) + m;
  }

  proc dec(k : key, n : nonce, c : ctxt) : ptxt = {
    return (f k n) + c;
  }
}.

module type NRCPA_Oraclei = {
  proc init() : unit
  proc en(n : nonce, m : ptxt) : ctxt option
}.

module O_NRCPA_real (S : NBEncScheme) : NRCPA_Oraclei = {


(*module type NRCPA_Oraclei = {
  proc init() : unit
  proc enc(n: nonce, m : ptxt) : cxt option
}

module O_NRCPA_real (S : NBEncScheme) : NRCPA_Oraclei = {
  var k : key
  var log : nonce list

  proc init() : unit = {
    k <@ S.kgen();

    log <- [];
  }

  proc enc(n : nonce, m : ptxt) : ctxt option = {
    var c : ctxt;
    var r : ctxt option;

    if (! (n \in log)) {
      log <- :: log;
      
      c <@ S.enc(k, n, m);

      r <- Some c;
    } else {
      r <- None;
    }

    return r;
  }
}.*)

