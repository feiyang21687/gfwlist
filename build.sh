#!/bin/bash

temp_gfwlist=$(mktemp)
echo "temporary gfw file=$temp_gfwlist"
trap 'rm -f -- $temp_gfwlist' INT TERM HUP EXIT

base64 -D gfwlist.txt > $temp_gfwlist

HEADER=`head -1 my_list.txt`
TAILER=`tail -1 my_list.txt`
echo "remove my list from gfwlist=${temp_gfwlist}"
#echo "sed -i "" '/${HEADER}/,/${TAILER}/d' $temp_gfwlist"
sed -i "" "/${HEADER}/,/${TAILER}/d" $temp_gfwlist

temp_list=$(mktemp)
echo "temporary merged gfw file=${temp_list}"
trap 'rm -f -- $temp_list' INT TERM HUP EXIT
cat $temp_gfwlist my_list.txt > ${temp_list}

base64 ${temp_list} > gfwlist.txt
