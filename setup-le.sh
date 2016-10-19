#!/usr/bin/bash
set -o nounset -o errexit

WORKDIR="/root/ipa-le"

dnf install letsencrypt -y

ipa-cacert-manage install "$WORKDIR/ca/isrgrootx1.pem" -n ISRGRootX1 -t C,,
ipa-cacert-manage install "$WORKDIR/ca/DSTRootCAX3.pem" -n DSTRootCAX3 -t C,,
ipa-certupdate -v

ipa-cacert-manage install "$WORKDIR/ca/LetsEncryptAuthorityX1.pem" -n letsencryptx1 -t ,,
ipa-cacert-manage install "$WORKDIR/ca/LetsEncryptAuthorityX2.pem" -n letsencryptx2 -t ,,
ipa-cacert-manage install "$WORKDIR/ca/LetsEncryptAuthorityX3.pem" -n letsencryptx3 -t ,,
ipa-cacert-manage install "$WORKDIR/ca/LetsEncryptAuthorityX4.pem" -n letsencryptx4 -t ,,
ipa-certupdate -v

"$(dirname "$0")/renew-le.sh" "--first-time"
