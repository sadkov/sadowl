#!/bin/sh

sensors_file="../sadowl-data/sensors"
readings_file="../sadowl-data/readings"



awk '
BEGIN {
    FS="/"
    values_sum[""]=0;
    values_count[""]=0;
    values_name[""]=0;
}
{
    if ( $0 ~ /\// ) {
	FS="/";
	$0=$0;
	#print $1 "*" $2 "*" $3 "*" values_name[$2];
	values_sum[$2]+=$3;
	values_count[$2]++;
	
    } else {
	FS=" ";
	$0=$0;
	#print $1 "<=>" $2
	values_name[$1]=$2
    }
    
}
END {
    for ( item in values_name) {
	if (values_name[item] == "") { continue }
	if (values_count[item] == 0) {
	    printf("%-20s\n", values_name[item])
	} else {
	    printf("%-20s %5.0f\n", values_name[item], values_sum[item]/values_count[item])
	}
    } 
}
' $sensors_file $readings_file | sort -n -k 2,2 -k 1,1 

 


