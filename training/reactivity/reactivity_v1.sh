#!/bin/bash
#set -x
#1 WHITE
#2 BLACK
#3 RED
#4 GREEN
#5 BLUE
#6 PINK
#7 ORANGE
#8 YELLOW
END=20
source map set
source global set

echo "show 3..,1,1,1" | nc $s1 $port
sleep 1
echo "show 2..,1,1,1" | nc $s1 $port
sleep 1
echo "show 1..,1,1,1" | nc $s1 $port
sleep 1

## define end value ##
END=20
x=$END 
echo "color 2" | nc $s1 $port

while [ $x -gt 0 ]; 
do 
  sleep $(( ( RANDOM % 7 )  + 1 ))
  echo "color 3" | nc $s1 $port
  time_cmd=$(gdate +%s%N)
  show_time=${time_cmd:0:13}
  sleep 1
  echo "color 2" | nc $s1 $port
  react_time=$(echo 'select * from traintech.measurements order by timestamp desc limit 1' | curl -s $database/'?query=' --data-binary @- |awk '{print $1}')
  delay=$((show_time - react_time))  
  echo $delay
  x=$(($x-1))
done
echo "show END,1,1,1" | nc $s1 $port
