#! /usr/bin/env bash

###############################################################################
#
# Deploy Template Changes Script
#
# Scripts updates all changes from the /templates/module directory for the 
# following files to the competency template directory:
#   Makefile
#   lab_tester.c
#   tests/test_case_generator.py
#   tests/testcaselib.py
#   lab_verification_test.py
#
# @file       update_comp_with_mod_temp.sh
# @author     upsetrobot
# @brief      Updates course files.
# @version    1.0.2
# @date       01 Mar 2024
#
# @copyright  Copyright (c) 2024
#
# And script rehashes files so that they all work including the 
# lab_verification_test.py which needs the hash of the add_testcases.py file.
#
############################################################################### 

echo 'This script will update the competency template in the course with the files from '
echo 'the module template. Specifically, this will update:'
echo -e '\t `Makefile`'
echo -e '\t `lab_tester.c`'
echo -e '\t `tests/test_case_generator.py`'
echo -e '\t `tests/testcaselib.py`'
echo -e '\t `.instructor\lab_verification_test.py`'
read -p "Do you want to continue ('y' for yes; 'n' for no): " decision

case $decision in
    [Yy]* )
        echo 'Starting script...'

    ;;
    * ) 
        echo 'Exiting...'
        exit
esac

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
COMP_DIR=$SCRIPT_DIR/competency

TEST_CASE_GEN_FILE=$SCRIPT_DIR/module/tests/test_case_generator.py
TEST_LIB_FILE=$SCRIPT_DIR/module/tests/testcaselib.py
LAB_VER_FILE=$SCRIPT_DIR/module/.instructor/lab_verification_test.py
MAKEFILE_FILE=$SCRIPT_DIR/module/Makefile
LABTESTER_FILE=$SCRIPT_DIR/module/lab_tester.c

# Hash files and insert hashes into test files.
echo 'Hashing files...'
cd $SCRIPT_DIR

sed -i "s|MAKEFILE_DIGEST = .*|MAKEFILE_DIGEST = '$(md5sum module/Makefile | awk '{print $1;}')'|" module/tests/test_case_generator.py
sed -i "s|TESTCASE_LIB_DIGEST = .*|TESTCASE_LIB_DIGEST = '$(md5sum module/tests/testcaselib.py | awk '{print $1;}')'|" module/tests/test_case_generator.py
sed -i "s|LAB_TESTER_DIGEST = .*|LAB_TESTER_DIGEST = '$(md5sum module/lab_tester.c | awk '{print $1;}')'|" module/tests/test_case_generator.py

sed -i "s|TEST_CASES_DIGEST = .*|TEST_CASES_DIGEST = '$(md5sum module/tests/add_testcases.py | awk '{print $1;}')' # *** <-- This line is mod specific|" module/.instructor/lab_verification_test.py
sed -i "s|TEST_CASE_GEN_DIGEST = .*|TEST_CASE_GEN_DIGEST = '$(md5sum module/tests/test_case_generator.py | awk '{print $1;}')'|" module/.instructor/lab_verification_test.py

cd $COMP_DIR

# Copy test library files and instructor verification files.
echo 'Copying test files...'
find . -type f -name test_case_generator.py -exec cp $TEST_CASE_GEN_FILE {} \;
find . -type f -name testcaselib.py -exec cp $TEST_LIB_FILE {} \;

echo 'Copying Instructor Verification File...'
find . -type f -name lab_verification_test.py -exec cp $LAB_VER_FILE {} \;

# Fix hashes for instructor verification files and add dirname.
echo 'Fixing test case hash for each verification file...'
for i in $(find . -type d -name .instructor)
do 
    if [ -e ${i%/}/lab_verification_test.py ]
    then 
        sed -i "s|TEST_CASES_DIGEST = .*|TEST_CASES_DIGEST = '$(md5sum ${i%/}/../tests/add_testcases.py | awk '{print $1;}')' # *** <-- This line is mod specific|" $i/lab_verification_test.py
    fi
done

# Copy makefiles and lab files.
echo 'Copying Makefile...'
find . -type f -name Makefile -exec cp $MAKEFILE_FILE {} \;

echo 'Copying Lab Tester Source...'
find . -type f -name lab_tester.c -exec cp $LABTESTER_FILE {} \;

echo 'All done.'


# End of file.