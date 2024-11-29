To run:

```shell
ENCLAVE_ID=$(nitro-cli run-enclave --eif-path node-tee-https.eif --debug-mode --cpu-count 2 --memory 2048 | jq -r '.EnclaveID')
nitro-cli console --enclave-id "$ENCLAVE_ID"
export VSOCK=$(nitro-cli describe-enclaves | jq '.[] | select(.EnclaveName == "node-tee-https") | .EnclaveCID')
socat TCP-LISTEN:8080,reuseaddr,fork VSOCK-CONNECT:$VSOCK:8080 &
```

To terminate the enclave:
```shell
nitro-cli terminate-enclave --enclave-name node-tee-https
```
