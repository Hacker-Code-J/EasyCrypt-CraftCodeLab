module J =
  struct
    open Ctypes
    open Foreign

    let enc = foreign "enc" (ocaml_bytes @-> ocaml_string @-> ocaml_string @-> ocaml_string @-> returning void)
    let dec = foreign "dec" (ocaml_bytes @-> ocaml_string @-> ocaml_string @-> ocaml_string @-> returning void)

  end

let enc k n m =
  let open Ctypes in
  let out = Bytes.create 16 in
  J.enc (ocaml_bytes_start out) (ocaml_string_start k) (ocaml_string_start n) (ocaml_string_start m);
  out |> Bytes.to_string

let () =
  let key = "0123456789abcdef" in
  let nonce = "0000000000000000" in
  let message = "Hi Jasmin World!" in
  let ciphertext = enc key nonce message in
  let result = enc key nonce ciphertext in
  Format.printf "%s@." result
