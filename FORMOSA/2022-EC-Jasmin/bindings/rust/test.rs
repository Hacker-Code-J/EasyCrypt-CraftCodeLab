#[link(name = "NbAES", kind = "static")]
extern "C" {
    fn enc(ciphertext: *mut u8, key: *const u8, nonce: *const u8, plaintext: *const u8);
    fn dec(plaintext: *mut u8, key: *const u8, nonce: *const u8, ciphertext: *const u8);
}

fn encrypt(key: u128, nonce: u128, message: u128) -> u128 {
    let k = key.to_le_bytes();
    let n = nonce.to_le_bytes();
    let m = message.to_le_bytes();
    let mut c = [0u8; 16];
    unsafe {
        enc(c.as_mut_ptr(), k.as_ptr(), n.as_ptr(), m.as_ptr());
    }
    u128::from_le_bytes(c)
}

fn decrypt(key: u128, nonce: u128, message: u128) -> u128 {
    let k = key.to_le_bytes();
    let n = nonce.to_le_bytes();
    let m = message.to_le_bytes();
    let mut p = [0u8; 16];
    unsafe {
        dec(p.as_mut_ptr(), k.as_ptr(), n.as_ptr(), m.as_ptr());
    }
    u128::from_le_bytes(p)
}

pub fn main() {
    let key: u128 = 0x0f0e0d0c0b0a09080706050403020100;
    let nonce: u128 = 0x1f0e0d0c0b0a09080706050403020100;
    let msg: u128 = 0x2f0e0d0c0b0a09080706050403020100;
    let ciphertext = encrypt(key, nonce, msg);
    let result = decrypt(key, nonce, ciphertext);
    assert_eq!(msg, result)
}
