#!/bin/bash
# Want to delete keys that have already been saved and moved
#   That way next iter is good to go
set -eu
gpg --delete-secret-keys $FPR
gpg --delete-keys $FPR
exit
