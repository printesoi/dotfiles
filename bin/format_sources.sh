#!/bin/bash

for file in *.c *.cpp *.h;do
	sed -i -e 's/\s\+$//g' -e 's/\t/    /g' $file;
done
