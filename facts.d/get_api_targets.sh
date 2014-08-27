#!/bin/bash
if [ -f ~/.zsapi.ini ]
then
  for i in `grep "\[" ~/.zsapi.ini |sed 's/\[\|\]//g'`
    do
      targets+=$i
    done
fi
echo zendapi.targets=$targets

