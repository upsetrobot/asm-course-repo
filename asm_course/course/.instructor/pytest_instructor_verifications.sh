#! /usr/bin/env bash

# Script runs pytest on each module as applicable.
# 

# This makes script able to be called from remote directory.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/..

# Run pytest in each instructor folder.
echo 'Running pytest on each module...'

for i in $(find . -type d -name '3-*' | sort)
do
    pytest --color=yes --import-mode=importlib -p no:cacheprovider --tb=line $i/.instructor | sed '1,7d'
done

# Clean pycache files.
find . -name '__pycache__' -exec rm -r {} 2>/dev/null \;


# End of file.
