#! /bin/bash +x

path=$1
files=$(ls $path)

i=1
for filename in $files
do
    file_array[i]=$filename
    ((i++))
done

len=${#file_array[@]}
echo $len

j=1
while ((j < len))
do
    echo "$j|0|Pictures/new_year/${file_array[$j]}" >> filename.txt

    ((j++))
done

# for filename in $files
# do
#     i=1
#     while (( $i <= ${files[@]}} ))
#     do
#         echo "$i|0|$filename" >> filename.txt 

#     done
# done
