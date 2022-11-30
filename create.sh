#!/bin/bash
<<COMMENT
This Script is the parent script to walk a user though the setup or a yubikey (or other gpg smartcard)
Either creating or importing a key, then moving it to the card/s
COMMENT

set -eu
export PARENT_DIR="$PWD"

new_key=true
key_file=""

# Make tmp dir to store keys
export KEY_DIR="/tmp/gpg_keys"
mkdir -p $KEY_DIR

<<COMMENT
Want to parse the command line to either import a key, or create a new one
COMMENT

for i in "$@"
do
case $i in
    -h )
                printf "usage: $0 \n\t[-k | --key] -  Make a new GPG key \n\t[-i | --import] - Import a new key \n"
                exit 0
                ;;

    -k | --key )
                new_key=true
                ;;

    -i | --import )
                new_key=false
                shift
                key_file="$1"
                ;;

    * )
                break
                ;;
esac
done


if [ $new_key = true ]; then
    echo "Your Name:"
    read name

    echo "Your Email:"
    read email

    $PARENT_DIR/gpg_keys/generate_keys.sh -n $name -e $email
else
    export key_file
    $PARENT_DIR/gpg_keys/import_keys.sh
fi

# Now move keys to card
$PARENT_DIR/to_card/card_setup.sh

# Now Create backup tar file
$PARENT_DIR/save_keys.sh

exit
