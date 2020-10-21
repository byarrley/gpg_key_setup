#!/bin/bash
# Move keys to card
set -eu

# Load Keys from folder (in tmpfs)
printf "\n\n***MAKE SURE TO SEE AND READ INSTRUCTIONS***\n\n"
printf "\n\n*Move Key 1 to card -> key 1, keytocard, (e), key 1, save \n\n"
gpg --edit-key $FPR

printf "\n\n*Move Key 2 to card -> key 2, keytocard, (s), key 2, save\n\n"
gpg --edit-key $FPR

printf "\n\n*Move Key 3 to card -> key 3, keytocard, (a), key 3, save\n\n"
gpg --edit-key $FPR

printf "\nNow Export Stubs\n"
gpg -a --export $FPR > "$KEY_DIR/stubs_$counter.key"
gpg -a --export $FPR > "$KEY_DIR/stubs_$counter.asc"

# These are not needed
gpg --armor --export-secret-subkey $FPR > "$KEY_DIR/stubs_subkey_$counter.asc"

exit
