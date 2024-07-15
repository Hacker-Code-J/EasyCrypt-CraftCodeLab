
- `my_proof.ec`

```easycrypt
module MyProof.

(* Your cryptographic proof goes here *)

end MyProof.
```

- Compile the Script with EasyCrypt:

```terminal
easycrypt my_proof.ec
easycrypt compile my_proof.ec
```

- Generate the ECA File:

```terminal
easycrypt compile -script NbEnc.ec >  NbEnc.eca
```
