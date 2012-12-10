#!/bin/ksh
cd /arch/oracle/prod/
for i in `ls arch_1_*.log`
do
echo $i
file_logseq=`echo $i| cut -f3 -d'_'`
echo $file_logseq
if [[ $file_logseq -gt 100 ]]
then
echo $i
cp $i /arch/oracle/prod/temp/$i
fi
done
