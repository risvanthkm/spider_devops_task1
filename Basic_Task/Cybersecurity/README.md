# CyberSecurity

## Cracking the ciphertext
By comparing the ciphertext letter frequencies with expected English letter frequencies and computing the chi-squared score for all 25 keys, the shift producing the lowest score is selected as the most likely plaintext.

The Chi-squared statistic was used to rank candidate plaintexts based on how closely their letter frequencies matched standard English letter frequencies.
**Formula**: χ² = Σ ((Oᵢ − Eᵢ)² / Eᵢ)

- χ2= Chi-squared score
- Oi = Observed frequency of letter i
- Ei = Expected frequency of letter i in English
- ∑ = Sum over all letters from a to z

Top 3 likely plaintexts are :

```
RANK 1 The quick brown fox jumps over the lazy dog. Cryptography is the art of writing and solving codes.

RANK 2 Gur dhvpx oebja sbk whzcf bire gur ynml qbt. Pelcgbtencul vf gur neg bs jevgvat naq fbyivat pbqrf.

RANK 3 Hvs eiwqy pfckb tcl xiadg cjsf hvs zonm rcu. Qfmdhcufodvm wg hvs ofh ct kfwhwbu obr gczjwbu qcrsg.
```


## CryptoVault

It is a python command-line tool, capable of encrypting and decrypting files using Caeser cipher.

Encryption command 

`python Cryptovault.py encrypt <filename> --shift <desired_shift>`

Decryption command 

`python Cryptovault.py decrypt <filename> --shift <desired_shift>`

Using --verify flag 
- It is used to verify whether the encrypted file has been modified or tampered with.

`python Cryptovault.py decrypt <filename> --shift <desired_shift> --verify`

## WRITEUP

**Why is Caesar trivially breakable?** 

The Caesar cipher is trivially breakable because it has a very small key space, 25.
Attacker can just use brute force with these 25 keys, and decrypt the text.
In modern world, Caesar cipher can be broken in seconds.

**What property of language makes frequency analysis work?**

Caesar cipher only shifts the letter but the frequencies remain the same.
We have some standard expeced frequencies by comparing it with the cipher text frequencies the attacker might crack the cipher

**Encryption gives confidentiality. Hashing gives integrity. Why do you need both?**

Encryption helps to hide the message from the intercepts.
Whereas, Hashing helps to detect the modification of the data.
Here, we need both because we can't use hashing to hide the message because once hashed cannot be retained.
Also the encryption doesn't guarentee us integrity, the attacker might modify the data but we can't detect the modification. So here we use encryption to hide the message and hashing to detect the tampering by comparing the hashes
