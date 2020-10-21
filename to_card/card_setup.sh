#!/bin/bash
# Keys should have already been loaded
set -eu

invalid_responce=true
counter=0
while [ $invalid_responce = true ]; do
    read -r -p "Move keys to card? [y/N] " responce
    case "$responce" in
        [yY][eE][sS|[yY])
            printf "\nNow Moving Keys\nPLEASE FOLLOW PROMTS\n"
            counter=$((counter+1))
            export counter
            ./move_keys.sh
            ./delete_keys.sh
            ./import_keys.sh   # key_file has been set somewhere else (either in generate or import)
            invalid_responce=true
            ;;
        [nN][eE][sS|[nN])
            printf "\nDone Moving Keys\n"
            invalid_responce=false
            ;;
        *)
            printf "\nYour reponce is not valid\n"
            invalid_responce=true
            ;;
esac
done

exit
