#!/bin/bash
# Import keys
#export GNUPGHOME=$(mktemp -d)
set -eu

gpg --import $key_file
FPR=$(gpg --list-options show-only-fpr-mbox --list-secret-keys | awk '{print $1}')
export FPR
printf "\nImported Key: $key_file\n"

exit
