import ctypes
import secrets

def load():
    nbaes = ctypes.cdll.LoadLibrary('./libNbAES.so')
    pt = ctypes.POINTER(ctypes.c_char)
    sig = [ pt, pt, pt, pt ]
    nbaes.enc.argtypes = sig
    nbaes.dec.argtypes = sig
    return nbaes

def roundtrip(nbaes, key, msg):
    nonce = secrets.token_bytes(16)
    n = ctypes.create_string_buffer(nonce)
    k = ctypes.create_string_buffer(key)
    c = ctypes.create_string_buffer(16)
    nbaes.enc(c, k, n, ctypes.create_string_buffer(msg))
    # print("Nonce: %s\nCiphertext: %s\n" % (nonce, c.value))
    p = ctypes.create_string_buffer(16)
    nbaes.dec(p, k, n, c)
    return p.value

if __name__ == '__main__':
    nbaes = load()
    m1 = b'Hi Jasmin World!'
    m2 = roundtrip(nbaes, b'0123456789abcdef', m1)
    print(">> %s\n<< %s\n" % (m1, m2))
    assert(m1 == m2)
