from itertools import chain
from Crypto.Cipher import AES
import hashlib
import os
import os.path
import chalk

class MyEncryptor:
    def __init__(self, key) -> None:
        self.key = key

    def encrypt(self, data):
        cipher = AES.new(self.key, AES.MODE_EAX)
        ciphertext, tag = cipher.encrypt_and_digest(data)
        return ciphertext, tag, cipher

    def encrypt_file(self, file_name):

        with open(file_name, 'rb') as fo:
            plaintext = fo.read()

        ciphertext , tag , cipher = self.encrypt(plaintext)

        with open(file_name + ".enc", 'wb') as fo:
            [ fo.write(x) for x in (cipher.nonce, tag, ciphertext) ]
            fo.close()
        os.remove(file_name)

    def decrypt(self, ciphertext, nonce, tag):     
        
        cipher = AES.new(self.key, AES.MODE_EAX, nonce)
        
        try:
            plaintext = cipher.decrypt_and_verify(ciphertext, tag)
            return plaintext.rstrip(b"\0")
        except ValueError:
           print("Key incorrect or message corrupted")          


    def decrypt_file(self, file_name):

        with open(file_name, 'rb') as fo:
            nonce, tag, ciphertext = [ fo.read(x) for x in (16, 16, -1) ]
        dec = self.decrypt(ciphertext, nonce, tag)
       
        if(dec == None):
          exit()  
        with open(file_name[:-4], 'wb') as fo:
            fo.write(dec)
            fo.close()
        os.remove(file_name)
 
    def getAllFiles(self,mode):
        dir_path = os.path.dirname(os.path.realpath(__file__))
        # This exclude will limit os.walk traversal. As here I am using virtual environment (venv)
        #  which must to be excluded
        exclude = set(['venv','.vscode'])
        dirs = []
        for dirName, subdirList, fileList in os.walk(dir_path, topdown=True):
            subdirList[:] = [d for d in subdirList if d not in exclude] # This will prune the search for subdirectories
            for fname in fileList:
                
                if(mode =='e'):
                    if(fname[-2:] != 'py' and fname[-3:] != 'enc'):
                        dirs.append(dirName + "\\" + fname)     
                elif(mode == 'd'):
                    if(fname[-3:] == 'enc'):
                        dirs.append(dirName + "\\" + fname)                        
        return dirs

    def encrypt_all_files(self):
        dirs = self.getAllFiles(mode='e')
     
        for file_name in dirs:
            self.encrypt_file(file_name)

    def decrypt_all_files(self):
        dirs = self.getAllFiles(mode='d')
        for file_name in dirs:
            self.decrypt_file(file_name)

clear = lambda: os.system('cls')

def generate_key(password):
    key = hashlib.sha256(password.encode('utf-8')).digest()
    return key
    
while True:
    clear()
    password = str(input(
        
        chalk.green("Enter a password that will be used for encryption/decryption: ")))
    repassword = str(input(chalk.green("Confirm password: ")))
    if password == repassword:
        # sha_256 = generate_key(password)        
        enc = MyEncryptor( generate_key(password) )
        break        
    else:
        print(chalk.red("Passwords Mismatched!"))

while True:
    clear()
    choice = int(input(
        chalk.yellow(
        "1. Press '1' to encrypt file.\n2. Press '2' to decrypt file.\n3. Press '3' to Encrypt all files in the directory.\n4. Press '4' to decrypt all files in the directory.\n5. Press '5' to exit.\n")))
    clear()
    if choice == 1:
        enc.encrypt_file()
    elif choice == 2:
        enc.decrypt_file()
    elif choice == 3:
        enc.encrypt_all_files()
    elif choice == 4:
        enc.decrypt_all_files()
    elif choice == 5:
        exit()
    else:
        print("Please select a valid option!")






