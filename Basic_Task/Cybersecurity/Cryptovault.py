import argparse
import hashlib

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

parser = argparse.ArgumentParser()

parser.add_argument("action", choices=["encrypt", "decrypt"])
parser.add_argument("file")
parser.add_argument("--shift", type=int, required=True)
parser.add_argument("--verify", action="store_true", required=False)

args = parser.parse_args()


if args.action == "encrypt":
    name = f"{args.action}ed_{args.file}"
    with open(args.file, 'r') as f:
        cont= f.read()
        open(name, "w").close()
        with open(name, 'a') as F:
            hash_value = (hashlib.sha256(cont.encode()).hexdigest())
            F.write("HASH:"+hash_value+"\n")
            F.write(caesar(cont, args.shift))

    print(f"File successfully encrypted => Encrypted File => {name}")

elif args.action == "decrypt":
    name = f"{args.action}ed_{args.file}"
    with open(args.file, 'r') as f:
        open(name, "w").close()
        with open(name, 'a' ) as F:
            for line in f:
                if line.startswith("HASH:"):continue
                F.write(caesar(line, -args.shift))
    print(f"Decrypted successfully, Decrypted File => {name}")

    if args.verify:
        try:
            name_en = f"{args.file}"
            with open(name_en, 'r') as f:
                for line in f:
                    if line.startswith("HASH:"):
                        b_hashed = line[5::].strip()
            with open(name, 'r') as F:
                decrypteds_hash = hashlib.sha256(F.read().encode()).hexdigest()

            if decrypteds_hash == b_hashed:
                print("The File is not tampered !!")
            else:
                print("The file is tampered !!")
                    
        except FileNotFoundError:
            print("File is not encrypted yet ...")



