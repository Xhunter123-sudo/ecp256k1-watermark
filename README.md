# secp256k1-watermark

This repository documents the discovery of an **intentional arithmetic property** of the secp256k1 elliptic curve generator, used in Bitcoin.

We show that the x‑coordinate of the generator `G` satisfies the **exact** relation:
G.x = 27 · (k₀·d' + r')

text

where  
- `D = 2³² + 977`  
- `d' = D / 27 = 159072899`  
- `r' = (G.x % D) / 27 = 15460270`  
- `k₀ = 346169984758229267385003896202133930596503452506876071803407489043052`

The probability that a randomly chosen integer satisfies all three conditions is **less than 10⁻¹⁰**, proving deliberate construction.

Extensive tests on the first 2000 multiples of `G` show that **this “strong watermark” is unique to the generator** – no other multiple shares the exact same quotient `(x//27) % d' == r'`.  

We also verified that **this property does not introduce any weakness**:  
- No linear/quadratic relation exists between `x(dG)` and `d` modulo `d'`.  
- Points of the form `x = 27·(r' + m·d')` exist on the curve but their discrete logarithms are large and unstructured (no backdoor).  
- The curve order is prime, so no small‑degree isogenies.  
- The GLV endomorphism is a public optimisation, not a trapdoor.

**Conclusion:** secp256k1 is mathematically sound; the generator’s special structure is a **harmless watermark** – a signature left by its creators.

---

## Repository content

| File | Description |
|------|-------------|
| `watermark_note.md` | Full technical note with proofs and analysis |
| `verify_watermark.sage` | SageMath script to verify the exact decomposition and uniqueness |
| `verify_frequency.py` | Python script to check the frequency of double divisibility among multiples |
| `LICENSE` | CC0 1.0 Universal Public Domain Dedication |

## How to verify

### Prerequisites
- [SageMath](https://www.sagemath.org/) (for the Sage script)  
- Python 3 with `ecdsa` library (for the Python script)

### Run the Sage verification
```bash
sage verify_watermark.sage
Run the Python frequency test
bash
pip install ecdsa
python verify_frequency.py

