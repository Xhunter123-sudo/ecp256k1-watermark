#!/usr/bin/env sage
# verify_watermark.sage
# Verification of the exact arithmetic watermark in secp256k1 generator

p = 2^256 - 2^32 - 977
Fp = GF(p)
E = EllipticCurve(Fp, [0,7])

Gx = 0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798
Gy = 0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8
G = E(Gx, Gy)

D = 2^32 + 977
d_prime = D // 27
r_prime = (G[0] % D) // 27

print("="*70)
print("Verification of the secp256k1 generator watermark")
print("="*70)
print(f"G.x = {G[0]}")
print(f"G.x % 27 = {G[0] % 27}")
print(f"G.x % D = {G[0] % D}  divisible by 27? {(G[0] % D) % 27 == 0}")
print(f"(G.x//27) % d' = {(G[0]//27) % d_prime}")
print(f"r' = {r_prime}")
assert (G[0]//27) % d_prime == r_prime, "ERROR: watermark not satisfied!"
print("\n✅ Generator passes the strong watermark test.\n")

# Uniqueness test among multiples
print("Testing uniqueness of strong watermark among first 2000 multiples...")
found = 0
for k in range(1, 2001):
    P = k * G
    x = P[0]
    if x % 27 == 0 and (x % D) % 27 == 0:
        q = (x//27) % d_prime
        if q == r_prime:
            found += 1
print(f"Points with strong watermark (k=1..2000): {found}")
if found == 1:
    print("✅ Strong watermark is unique to the generator (k=1).")
else:
    print("❌ Unexpected! Multiple points with strong watermark found.")
