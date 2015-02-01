#/bin/bash
zip -l ~kermit/archives/kermit11.zip -n ps pdf * || exit 1
zip ~kermit/archives/kermit11.zip *.ps *.pdf || exit 1
cd ~kermit/archives
ls -ldga kermit11.zip || exit 1
unzip -t kermit11.zip
cd ~kermit/archives
chmod 644 kermit11.zip
chgrp kermit kermit11.zip
exit 0
