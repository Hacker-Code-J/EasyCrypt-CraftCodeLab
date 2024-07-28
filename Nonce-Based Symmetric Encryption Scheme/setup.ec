require import AllCore List Distr.

(* Types for keys, plaintexts, nonces, respectively *)
type key, ptxt, nonce.

(* Type for ciphertexts *)
type ctxt = ptxt.

(* Binary infix operator on plaintexts *)
op (+) : ptxt -> ptxt -> ptxt.

(* Family of functions from nonces to plaintexts, indexed by keys *)
op f : key -> nonce -> ptxt.

(* Subdistribution over keys *)
op dkey : key distr.

(* Associativity, commutativity, and "self-inverse" property of the binary operator, respectively *)
axiom addpA (x y z : ptxt) : x + y + z = x + (y + z).
axiom addpC (x y : ptxt) : x + y = y + x.
axiom addKp (x y : ptxt) : x + x + y = y.

(* 
  Module type for (symmetric) nonce-based encryption schemes.
  Intuitively, this specifies the interface that such 
  encryption schemes are expected to implement.
*)
module type NBEncScheme = {
  proc kgen(): key
  proc enc(k : key, n : nonce, m : ptxt): ctxt
  proc dec(k : key, n : nonce, c : ctxt): ptxt
}.

(* 
  Specification of the considered nonce-based encryption scheme.
  Because the module implements all the procedures specified in the NBEncScheme
  module type, the module has this type (making it valid to give it this type).  
*)
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

(* ======================================================== *)
module type NRCPA_Oraclei = {
  proc init() : unit
  proc enc(n : nonce, m : ptxt) : ctxt option
}.

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
      log <- n :: log;
      
      c <@ S.enc(k, n, m);
      
      r <- Some c;
    } else {
      r <- None;
    }
    
    return r;
  }
}.

op [lossless full uniform] dctxt : ctxt distr.

module O_NRCPA_ideal : NRCPA_Oraclei = {
  var log : nonce list

  proc init() : unit = {
    log <- [];
  }

  proc enc(n : nonce, m : ptxt) : ctxt option = {
    var c : ctxt;
    var r : ctxt option;
    
    if (! (n \in log)) {
      log <- n :: log;
      
      c <$ dctxt;
      
      r <- Some c;
    } else {
      r <- None;
    }
    
    return r;
  }
}.

module type NRCPA_Oracle = {
  include NRCPA_Oraclei [enc]
}.

module type Adv_IND_NRCPA (O : NRCPA_Oracle) = {
  proc distinguish() : bool
}.

module Exp_IND_NRCPA (O : NRCPA_Oraclei) (D : Adv_IND_NRCPA) = {
  proc run() : bool = {
    var b : bool;

    O.init();
    
    b <@ D(O).distinguish();
    
    return b;
  }
}.

(* ======================================================== *)
