#!/bin/bash
start_time=$(date +%s%N)
for ((i=0; i<10000000; i++))
do
  a=$((i * i))
done
end_time=$(date +%s%N)
execution_time=$(( (end_time - start_time) / 1000000 ))
echo "Execution time: $execution_time milliseconds"
