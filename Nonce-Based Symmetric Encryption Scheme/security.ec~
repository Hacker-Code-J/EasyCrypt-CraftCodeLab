require import AllCore List Distr.

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
