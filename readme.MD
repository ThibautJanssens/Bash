# Cheat sheet for bash scripting.

### First line of script bash must be 
`#!/bin/bash`   or    `#!/bin/env bash`

### Calling the script
`sh scriptName.sh` or `./scriptName.sh`  
*If you're using the second method, don't forget to use `chmod +x scriptName.sh`*

### Taking the parameters when calling the script
`./hello.sh World`  
``` bash
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
``` bash  
    while [ $i -lt 5 ] do
        echo "i is currently $i"
        i=$[$i+1] #Note the lack of spaces around the brackets. This makes it a not a test expression
    done
```   
*Loop can be made C-Style*
``` bash  
    for (( i = 0; i < 10; i++ )) do
        echo "The iteration number is $i"
    done

    for (( i = 0, j = 0; i < 10; i++, j = i * i )) do
        echo "The square of $i is equal to $j"
    done  
```  
##### until *(until condition is true)*  
``` bash  
    i=5
    until [[ i -eq 10 ]]; do #Checks if i=10
        echo "i=$i" #Print the value of i
        i=$((i+1)) #Increment i by 1
    done
```  
### Switch case  
``` bash  
    case expression in
        pattern1 )
            statements ;;
        pattern2 )
            statements ;; # ;; == break; of other language
    esac
``` 
*ex:*  
``` bash  
    for filename in $(ls) do
	# Take extension available in a filename
        ext=${filename##*\.}
        case "$ext" in
            c) 
                echo "$filename : C source file"
                ;;
            o) 
                echo "$filename : Object file"
                ;;
            sh) 
                echo "$filename : Shell script"
                ;;
            txt) 
                echo "$filename : Text file"
                ;;
            *) 
                echo " $filename : Not processed"
                ;;
        esac
    done  
``` 
### Array  
``` bash  
    array=(1 2 3 4)
    arr=('first' 'second' 'third')
    arr1=([3]='fourth element' [4]='fifth element')
    arr2[0]='first element'
    declare -A arr3
    arr3[first]='First element'
    arr3[second]='Second element'
    arr4=("$@") #assignment from script's input arguments

    #access element
    echo "${array[0]}"
    echo "${array[-1]}" #print last element using subscript syntax
    echo "${array[@]}" #print all element quoted separately
    echo "${array[*]}" #print all element as a single quoted string
    echo "${array[@]:1}" #print all elements from index 1 each quoted separately
    echo "${array[@]:1:3}" #print 3 elements from index 1, each quote separately
    
    array=("${array[@]}" "fourth element" "fifth element") #replace the entire array with new parameter list

    array=("new element" "${array[@]}") #add element at the beginning
```  
** * Insert * **  
``` bash
    arr=(a b c d)
    # insert an element at index 2
    i=2
    arr=("${arr[@]:0:$i}" 'new' "${arr[@]:$i}")
```  
** * Delete * **  
``` bash  
    arr=(a b c)
    echo "${arr[@]}" # outputs: a b c
    echo "${!arr[@]}" # outputs: 0 1 2
    unset -v 'arr[1]' 
    echo "${arr[@]}" # outputs: a c
    echo "${!arr[@]}" # outputs: 0 2
```  
** * Merge * **  
``` bash
    array3=("${array1[@]}" "${array2[@]}")
```  
### Array Iteration
``` bash
    a=(1 2 3 4)
    # foreach loop
    for y in "${a[@]}"; do    
        echo "$y" # act on $y
    done
    # classic for-loop
    for ((idx=0; idx < ${#a[@]}; ++idx)); do 
        echo "${a[$idx]}" # act on ${a[$idx]}
    done
```  
### Array Length  
``` bash  
    array=('first element' 'second element' 'third element')
    echo "${#array[@]}" # gives out a length of 3
```  
### Array (map style)  
``` bash
    declare -A aa
    aa=([hello]=world [ab]=cd ["key with space"]="hello world")
    # same as 
    # aa[hello]=world
    # aa[ab]=cd
    # aa["key with space"]="hello world"

    echo "${aa[@]}" #Output: world cd hello world
    
    for key in "${!aa[@]}"; do
        echo "Key: ${key}"
        echo "Value: ${array[$key]}"
    done
    # Output
    # Key: hello
    # Value: world
    # Key: ab
    # Value: cd
    # Key: key with space
    # Value: hello world

    echo "${#aa[@]}" # Out: 3
```  
### Array Loop  
``` bash  
    for i in "${arr[@]}"; do
        echo "$i"
    done

    #c-style for
    for ((i=0;i<${#arr[@]};i++)); do
        echo "${arr[$i]}"
    done

    #while
    i=0
    while [ $i -lt ${#arr[@]} ]; do # or while (( $i < ${#arr[@]} )); do
        echo "${arr[$i]}"
        i=$((i + 1)) # or ((i++))
    done

    #until
    i=0
    until [ $i -ge ${#arr[@]} ]; do
        echo "${arr[$i]}"
        i=$((i + 1))
    done
```  
** * Destroy array * **  
``` bash
    unset array
```  
** * Delete single array element * **  
``` bash  
    unset array[10]
```  
### Function
``` bash  
    #with return
    function positive() {
        return 0
    }
    function negative() {
        return 1
    }
    greet() {
        local name="$1"
        echo "Hello, $name"
    }
    greet "John Doe" #calling function with parameters
```  
*You can export function so it can be exposed to child processes*  
`export -f greet` *to be used:* `bash -c 'greet'`  
### Find
##### Searching file/directory by name or extension  
```  bash  
#To find files/directories with a specific name, relative to pwd :
$ find . -name "myFile.txt"
#output: ./myFile.txt
#To find files/directories with a specific extension, use a wildcard:
$ find . -name "*.txt"
#output: ./myFile.txt
#output: ./myFile2.txt
#To find files/directories matching one of many extensions, use the or flag:
$ find . -name "*.txt" -o -name "*.sh"
#To find files/directories which name begin with abc and end with one alpha character following a one digit:
$ find . -name "abc[a-z][0-9]"
#To find all files/directories located in a specific directory
$ find /opt
#To search for files only (not directories), use -type f :
find /opt -type f
#To search for directories only (not regular files), use -type d :
find /opt -type d
```  
##### Filter the path  
``` bash  
#To find only files containing log anywhere in their path (folder or name):
find . -type f -path '*log*'
#To find only files within a folder called log (on any level):
find . -type f -path '*/log/*'
#To find only files within a folder called log or data :
find . -type f -path '*/log/*' -o -path '*/data/*'
#To find all files except the ones contained in a folder called bin :
find . -type f -not -path '*/bin/*'
#To find all file all files except the ones contained in a folder called bin or log files:
find . -type f -not -path '*log' -not -path '*/bin/*'
```  
##### Filter by type  
``` bash 
#To find files, use the -type f flag
$ find . -type f
#To find directories, use the -type d flag
$ find . -type d
#To find block devices, use the -type b flag
$ find /dev -type b
#To find symlinks, use the -type l flag
$ find . -type l
```  
