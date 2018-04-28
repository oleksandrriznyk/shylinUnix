#!/bin/bash

javac Prog.java
gcc imh.c
mv a.out 1.out
gcc hello.c
mv a.out 2.out

java Prog
./2.out &
./1.out
echo text-blah-blah-blah > pipe
