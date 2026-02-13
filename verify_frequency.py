from ecdsa import SECP256k1, SigningKey

G = SECP256k1.generator
D = (1 << 32) + 977
d_prime = D // 27
r_prime = (G.x() % D) // 27

count = 0
for k in range(1, 2001):
    x = (k * G).x()
    if x % 27 == 0 and (x % D) % 27 == 0:
        count += 1
print(f"Double divisibility frequency: {count}/2000 = {count/2000*100:.2f}%")
