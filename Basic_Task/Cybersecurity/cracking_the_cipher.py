alphabets = [
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
    'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
    'u', 'v', 'w', 'x', 'y', 'z'
]

def caesar(text, shift):
    cipher = ""

    for char in text:
        if char.lower() not in alphabets:
            cipher += char
            continue

        old_index = alphabets.index(char.lower())
        new_index = (old_index + shift) % 26

        if char.isupper():
            cipher += alphabets[new_index].upper()
        else:
            cipher += alphabets[new_index]

    return cipher

def chi_squared(text: str):

    """ Chi squared determines how much the text is closer to English.
    X^2 = i=a∑z (Observed_freq - Expected_freq)^2 / Expected_freq
    
    """

    english_freq = {
        'a': 8.17, 'b': 1.49, 'c': 2.78, 'd': 4.25, 'e': 12.70,
        'f': 2.23, 'g': 2.02, 'h': 6.09, 'i': 6.97, 'j': 0.15,
        'k': 0.77, 'l': 4.03, 'm': 2.41, 'n': 6.75, 'o': 7.51,
        'p': 1.93, 'q': 0.10, 'r': 5.99, 's': 6.33, 't': 9.06,
        'u': 2.76, 'v': 0.98, 'w': 2.36, 'x': 0.15, 'y': 1.97,
        'z': 0.07
    }

    letters = [c.lower() for c in text if c.isalpha()]
    total = len(letters)

    if total == 0:        
        return float('inf')

    counts = {}
    for c in letters:
        counts[c] = counts.get(c, 0) + 1

    chi2 = 0.0
    for letter, expected_pct in english_freq.items():
        observed_pct = (counts.get(letter, 0) / total) * 100
        chi2 += (observed_pct - expected_pct) ** 2 / expected_pct

    return chi2

with open("message.txt", 'r') as f:
    cont = f.read()
decrypt_chi = []
for i in range(25):
    decr = caesar(cont, -i)
    decrypt_chi.append((decr, chi_squared(decr)))

for c, i in enumerate(sorted(decrypt_chi, key = lambda x: x[1])):
    print(f"RANK {c+1}", end = " ")
    print(i[0])
    if c==2:break