# Cheat sheet for bash scripting.

### First line of script bash must be 
`#!/bin/bash`   or    `#!/bin/env bash`

### Calling the script
`sh scriptName.sh` or `./scriptName.sh`  
*If you're using the second method, don't forget to use `chmod +x scriptName.sh`*

### Taking the parameters when calling the script
`./hello.sh World`  
```
    printf "Hello, %s\n" "$1"
```

### Control structures
+ ** *File Operators* **  
`-e "$file"`  Returns true if the file exists.  
`-d "$file"`  Returns true if the file exists and is a directory.  
`-f "$file"`  Returns true if the file exists and is a regular file.  
`-h "$file"`  Returns true if the file exists and is a symbolic link.  

+ ** *String Comparators* **  
`-z "$str"`  True if length of string is zero.  
`-n "$str"`  True if length of string is non-zero.  
`"$str" = "$str2"`  True if $str is equal to string $str2. Not best for integers. Can be inconsitent.  
`"$str" != "$str2"`  True if strings are not equal.  

+ ** *Integer Comparators* **  
`"$int1" -eq "$int2"`  True if the integers are equals.  
`"$int1" -ne "$int2"`  True if the integers are not equals.  
`"$int1" -gt "$int2"`  True if int1 is greater than int2.  
`"$int1" -ge "$int2"`  True if int1 is greater than or equal to int2.  
`"$int1" -lt "$int2"`  True if int1 is less than int2.  
`"$int1" -le "$int2"`  True if int1 is less or equal to int2.  

### Condition
``` bash
    if (( $1 + 5 > 91));then
        echo "$1 is greater than 86"
    fi
```  
``` bash
    if grep "foo" bar.txt; then  
        echo "foo was found"  
    else
        echo "foo was not found"
    fi
```
``` bash  
    if [[ $1 -eq 1 ]]; then
        echo "1 was passed in the first parameter"
    elif [[ $1 -gt 2 ]]; then
        echo "2 was not passed in the first parameter"
    else
        echo "The first parameter was not 1 and is not more than 2."
    fi
```  

### How to make a loop
##### foreach
``` bash  
    arr=(a b c d e f)
    for i in "${arr[@]}"; do
        echo "$i"
    done
``` 
 
##### for  
``` bash
    for ((i=0;i<${#arr[@]};i++));do
        echo "${arr[$i]}"
    done
```  

##### while  
``` bash
    i=0
    while [ $i -lt ${#arr[@]}];do
        echo "${arr[$i]}"
        i=$(expr $i +i)
    done
```  