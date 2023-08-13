# How Certificate Works over Internet

Below steps performed to get certificate issue resolved in SAP ABAP 1909 A4H

[OPENSSL installer](https://slproweb.com/products/Win32OpenSSL.html)

1. Create Private Key

`sh openssl genrsa -des3 -out rootCA.key 2048`

2. Create Public Key 

`sh openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 9999  -out rootCA.pem`

3. Make your OS comfortable with new Public Key 

4. Upload this public key in STRUST (SAP Side) & create DB entries

5. Create a signing request from SAP side 
	
6. create one ext file --> v3.ext

```sh
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = vhcala4hci
```

7. Create a new SSL certificate from CSR using Self CA / Public Key

`sh openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.crt -days 999 -sha256 -extfile v3.ext​`

8. upload the certificate response back to SAP (STRUST).

		WE ARE DONE!!!
<img src="https://github.com/developedbysom/youtube-publish/assets/70325382/7c38192e-31b9-4a71-ada0-40783f6382f6" width="400" height="300" />



