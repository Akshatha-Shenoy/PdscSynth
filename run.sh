#!/bin/bash

if [ $# -lt 1 ];
then
    echo "Usage: run.sh file.cpp [input_file.smt2] [vars]*"
    echo "If everything is fine, creates a binary 'file' and runs it"
    exit 1
else
    input_file=$1
fi

output_bin="${input_file%.*}"

g++ -I /home/u1913883/z3/src/api -I /home/u1913883/z3/src/api/c++ -ggdb -o $output_bin $input_file -L/home/u1913883/z3/build -lz3

if [ $? -ne 0 ];
then
    exit 1
fi

if [ $? -eq 0 ]; then
    shift
    ./$output_bin $@
fi
