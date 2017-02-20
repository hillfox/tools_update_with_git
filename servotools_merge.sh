#!/bin/bash
echo "-------------------------------------------------------"
timestamp=$( date +"%Y-%m-%d" )
echo $timestamp

# echo 'Updating the latest servotools from J:/servotools_replica to C:/servotools_update2016/servotools_replica...'
cd /cygdrive/c/servotools_update2016/servotools_replica/
servotools_check="/cygdrive/j/Servotools_Replica/fs_spk2.log"
if [ ! -f $servotools_check ]
then
   echo "J:/servotools_Replica seems not accessable, EXIT without updating!!!!"
   exit      
fi
  
search_dir="Servotools"
for entry in $(find $search_dir)
do
 if [ -f $entry ]  #check  the file deletion
 then
     entry2="/cygdrive/j/Servotools_Replica/${entry:11}"
     if [ ! -f $entry2 ]
     then
	    if [ $entry2 != "/cygdrive/j/Servotools_Replica/matlab/scripts/common/site/muskiesiteinfo.ini" ] && [ $entry2 != "/cygdrive/j/Servotools_Replica/matlab/scripts/dart/notch_design/scalec2d_2.m"  ]
		then
            echo "$entry2 not found, removing file $entry..."
		    rm -rf $entry
		fi
     fi
 fi	 
done

for entry in $(find $search_dir)
do	 
 if [ -d $entry ]  #check  the folder deletion
 then
     entry2="/cygdrive/j/Servotools_Replica/${entry:11}"
     if [ ! -d $entry2 ]
     then
        echo "$entry2 not found,removing directory $entry..."
		rm -rf $entry
     fi 
  fi 
done

cp -R --force /cygdrive/j/Servotools_Replica/* Servotools
commitString="servotools_update_$timestamp"
git add *
git commit -m $commitString
git pull
git push

#echo 'Geting the latest servotools from C:/servotools_update2016/shared.git to C:/servotools_update2016/servotools_local ...'
cd /cygdrive/c/servotools_update2016/servotools_local
commitStringLocal="servotools_local_update_$timestamp"
git fetch
git merge origin/master -m $commitStringLocal

#clean up C:/servotools_update2016/servotools_new/* first
rm -rf /cygdrive/c/servotools_update2016/servotools_new/*
#echo 'copying C:/servotools_update2016/servotools_local to C:/servotools_update2016/servotools_new...'
cp -R --force Servotools/binaries C:/servotools_update2016/servotools_new
cp -R --force Servotools/casa C:/servotools_update2016/servotools_new
cp -R --force Servotools/lauterbach C:/servotools_update2016/servotools_new
cp -R --force Servotools/matlab C:/servotools_update2016/servotools_new
cp -R --force Servotools/python C:/servotools_update2016/servotools_new
cp -R --force Servotools/tabu2 C:/servotools_update2016/servotools_new
cp -R --force Servotools/cl.txt C:/servotools_update2016/servotools_new


#echo 'Finally, copy servotools_new to J:/Servotools_new...'
   rm -rf J:/Servotools_new2/*
   cp -R C:/servotools_update2016/servotools_new2/binaries J:/Servotools_new
   cp -R C:/servotools_update2016/servotools_new2/casa J:/Servotools_new
   cp -R C:/servotools_update2016/servotools_new2/lauterbach J:/Servotools_new
   cp -R C:/servotools_update2016/servotools_new2/matlab J:/Servotools_new
   cp -R C:/servotools_update2016/servotools_new2/python J:/Servotools_new
   cp -R C:/servotools_update2016/servotools_new2/tabu2 J:/Servotools_new
   cp -R C:/1_seagate/servoupdatelog.txt J:/Servotools_new2




