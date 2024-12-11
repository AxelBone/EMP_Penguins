#!/bin/bash

input="/home/genouest/tp_emp_tps_40958/tp59985/EMP/TP5-8/data/raw_data"
cd "$input"
for zipfile in *.zip; do
    if [[ -f "$zipfile" ]]; then
        dirname="${zipfile%.zip}"
        mkdir -p "$dirname"
        unzip "$zipfile" -d "$dirname"
	rm "$zipfile"
    fi
done
