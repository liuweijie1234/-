#!/bin/bash

array_name=(zhang zheng zhou liu)

echo "显示所有数组中的元素\${array_name[@]}:${array_name[@]}"
echo "下标获取元素\${array_name[2]}：${array_name[2]}"
echo "获取数组元素的个数\${#array_name[@]}:${#array_name[@]}"
echo "\${#array_name[*]}:${#array_name[*]}"
echo "获取数组单个元素的长度\${#array_name[2]}:${#array_name[2]}"
