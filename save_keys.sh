#!/bin/bash
# Now save encrypted archive of keys

set -eu

 # Want to tar keys and encrypt for long term storag
 TAR_FILE="/tmp/archive_keys_"$(date +'%d_%m_%Y')".tar.gz"
 # Tar Folder
 tar -zcf $TAR_FILE -C $KEY_DIR .


 # And Encrypt
 printf "\nWill be prompted for passphrase for TAR backup\n"
 printf "\nUsing an alternate terminal run the command (openssl rand -base64 48) to generate passwd\n"
 sleep 10
 gpg \
     --symmetric \
     --cipher-algo AES256 \
     --digest-algo sha256 \
     --cert-digest-algo sha256 \
     --compress-algo none -z 0 \
     --s2k-mode 3 \
     --s2k-digest-algo sha512 \
     --s2k-count 65011712 \
     --force-mdc \
     --quit --no-greeting \
     --pinentry-mode=loopback \
     $TAR_FILE


 # And Export Stubs to folder
 STUBS_FOLDER="/tmp/stubs"
 mkdir -p $STUBS_FOLDER
 cp $KEY_DIR/stubs_subkey_* $STUBS_FOLDER/

 # Delete Secret keys
 gpg --delete-secret-keys $FPR

 # Delete Non encrypted Key_dir
 rm -rf $KEY_DIR

 # Make archive folder and move needed to it
 mkdir -p $HOME/GPG_Archive
 mv "$TAR_FILE.gpg" $HOME/GPG_Archive/
 mv $STUBS_FOLDER $HOME/GPG_Archive/

 exit
