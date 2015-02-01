#/bin/bash
zip -l ~kermit/archives/krt11.zip -n ps pdf * || exit 1
zip ~kermit/archives/krt11.zip *.ps *.pdf || exit 1
cd ~kermit/archives
ls -ldga krt11.zip || exit 1
unzip -t krt11.zip
cd ~kermit/archives
chmod 644 krt11.zip
chgrp kermit krt11.zip
exit 0
