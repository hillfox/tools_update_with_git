echo off
cd C:/1_seagate
set PATH=C:\cygwin64\bin;%PATH%
c:\cygwin64\bin\bash servotools_merge.sh 2>&1 | tee -a servoupdatelog.txt
echo on
