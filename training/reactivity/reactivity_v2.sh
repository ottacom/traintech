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
source ../map set
source ../global set
TTL=1
MAX_INTERVAL=5
#CLEAN DATABASE
echo 'truncate table traintech.measurements' | curl -s $database/'?query=' --data-binary @- |awk '{print $1}'
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
sel_colors=(3 7 4)
while [ $x -gt 0 ]; 
do 
  random_index=$(( RANDOM % ${#sel_colors[@]} ))
  color=${sel_colors[$random_index]}
  sleep $(( ( RANDOM % $MAX_INTERVAL )  + 1 ))
  echo "color $color" | nc $s1 $port
  time_cmd=$(gdate +%s%N)
  show_time=${time_cmd:0:13}
  sleep $TTL
  echo "color 2" | nc $s1 $port
  event=$(echo 'select * from traintech.measurements order by timestamp desc limit 1' | curl -s $database/'?query=' --data-binary @-)
  react_time=$(echo $event | awk '{print $1}')
  color=$(echo $event | awk '{print $2}' )
  delay=$((show_time - react_time))  
  echo $delay $color
  x=$(($x-1))
done
echo "show END,1,1,1" | nc $s1 $port
