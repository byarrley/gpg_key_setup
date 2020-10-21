#!/bin/bash

set -eu

printf "\nGENERATE KEYS\n"

# These will need to be set. Either by makeing a key, or importing a key
export USER_NAME="localhost"
export USER_EMAIL="none@localhost"
export ALGO="rsa"
export KEY_SIZE="4096"
export EXP_DATE="never"


for i in "$@"
do
case $i in
    -n | --name )       shift
                        USER_NAME="$1"
                        ;;
    -e | --email )      shift
                        USER_EMAIL="$1"
                        ;;
    -a | --algo )       shift
                        ALGO="$1"
                        ;;
    -s | --size )       shift
                        KEY_SIZE="$1"
                        ;;
    -d | --date )       shift
                        EXP_DATE="$1"
                        ;;
    * )
                        shift
                        ;;
esac
done

KALGO="$ALGO$KEY_SIZE"
export KALGO

gpg --batch --quick-generate-key "$USER_NAME <$USER_EMAIL>" $KALGO cert $EXP_DATE
FPR=$(gpg --list-options show-only-fpr-mbox --list-secret-keys | awk '{print $1}')

printf "\nEDIT KEYS\n"
gpg --batch --quick-add-key $FPR $KALGO encrypt $EXP_DATE
gpg --batch --quick-add-key $FPR $KALGO sign $EXP_DATE
gpg --batch --quick-add-key $FPR $KALGO auth $EXP_DATE
## --passphrase $PASSWD

printf "\nSAVE KEYS\n"
# How to export keys (and import): https://gist.github.com/srijanshetty/65e7b9ede7e12743fbd7
# Generate Revoke Cert
# gpg --gen-revoke $USER_EMAIL > $KEY_DIR/revoke.asc

# Non Secret
gpg -a --export $FPR > $KEY_DIR/public.key
gpg -a --export --armor $FPR > $KEY_DIR/public.asc

# Secret
gpg -a --export-secret-keys $FPR > $KEY_DIR/secret.key
gpg -a --export-secret-keys --armor $FPR > $KEY_DIR/secret.asc

# Export OwnerTrust
gpg --export-ownertrust > $KEY_DIR/backup_ownertrust.txt

printf "\nEXPORTED KEYS\n"

export FPR
export key_file=$KEY_DIR/secret.asc

exit
