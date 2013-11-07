#!/bin/bash

#Copy the test data in the folder
cp test_data/mobidic_test_data.tar input_dir/
#Untar the single basin files
tar xvf input_dir/mobidic_test_data.tar -C input_dir/
rm input_dir/mobidic_test_data.tar
./exe_import.sh
