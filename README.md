# GPG Key to Card
Script to create GPG keys and add them to key cards. <br />
The script will also make an encrypted backup of the original keys, for an offline safe backup. New yubikeys can be created from this.

# How to Use
Recommend downloading scripts to flashdrive and bringing over to a LiveBoot install. <br />
Head command script:  create.sh <br />
This will start the key creation and moves them over to the yubikeys.

# TAILS Setup
Best to use a liveboot os to make GPG keys.  If host OS is compromized then GPG keys could be as well. <br />
Tails leaves no trace on the host, and is Amnesic.  Need GPG 2.2(?) which should be supported. <br />

## Where to get TAILS
Tails:  https://tails.boum.org/install/index.en.html <br />
Tails Secure Erase:  https://tails.boum.org/doc/encryption_and_privacy/secure_deletion/index.en.html <br />

# GPG keys
If I read the NIST documents right. RSA 4096 is safe to store secret information until 2031. <br />
https://gnupg.org <br />
https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-56Ar3.pdf <br />
So according to (https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Module-Validation-Program/documents/fips140-2/FIPS1402IG.pdf)
RSA 4096 holding the AES-256 key provides 128 bits of security. Pg. 119-121  <br />

# Yubikey
Yubikey is a removable fido key, that can also hold gpg keys. <br />
Information can be found: https://www.yubico.com <br />

## YUBIKEY Setup
https://support.yubico.com/support/solutions/articles/15000006420-using-your-yubikey-with-openpgp <br />
https://gist.github.com/srijanshetty/65e7b9ede7e12743fbd7 <br />
https://www.richard-purves.com/2017/02/13/locking-macos-with-yubikey-4-piv-and-pam/ <br />

# Document Layout
create.sh - This starts the process

## gpg_keys
delete_keys.sh - Deletes GPG private and public keys (after moving to card, this is the key stubs) <br />
generate_keys.sh - Generate GPG Keys for yubikey.  Make an RSA key for SEC.
>USER_NAME - Name to put on Card <br />
>USER_EMAIL - User email <br />
>ALGO - Which algorithm to use (RSA) for the keys <br />
>KEY_SIZE - Key size for the algorithm <br />
>EXP_DATE - Date which public key will expire <br />
import_keys.sh - Import GPG key, used when making new Yubikey <br />

## to_card
card_setup.sh - Once keys loaded ask user if they want to move keys to card <br />
move_keys.sh - Prompts user to move GPG keys to card (yubikey) <br />
