#!/bin/ksh

if [[ `date +%u` -ne 6 ]]
then
   echo "Day is before Saturday"

   #exit 1
fi

if [[ `date +%d` -gt 4 ]]
then
  echo "This is 1st week"
  #exit 1
fi

