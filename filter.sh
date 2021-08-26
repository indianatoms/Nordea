#!/bin/bash

# the name of the script without a path
name=`basename $0`

# function for printing error messages to diagnostic output
error_msg() 
{ 
        echo "$name: error: $1" 1>&2 
}

# function for servicing -f option
set_file() 
{ 
        if test -z "$1"
        then
                error_msg "missing argument for -f"
                exit 1
        fi
        file=$1	
}

# function for servicing -S option
set_second() 
{ 
        if test -z "$1"
        then
                error_msg "missing argument for -S"
                exit 1
        fi
        second=$1	
}

# function for servicing -M option
set_minute() 
{ 
        if test -z "$1"
        then
                error_msg "missing argument for -M"
                exit 1
        fi
        minute=$1	
}

# function for servicing -H option
set_hour() 
{ 
        if test -z "$1"
        then
                error_msg "missing argument for -H"
                exit 1
        fi
        hour=$1	
}

# function for servicing -d option
set_day() 
{ 
        if test -z "$1"
        then
                error_msg "missing argument for -d"
                exit 1
        fi
        day=$1	
}

# function for servicing -d option
set_month() 
{ 
        if test -z "$1"
        then
                error_msg "missing argument for -m"
                exit 1
        fi
        month=$1	
}

# function for servicing -d option
set_year() 
{ 
        if test -z "$1"
        then
                error_msg "missing argument for -y"
                exit 1
        fi
        year=$1	
}

print_help()
{
    cat<<EOT 1>&2

usage:
  $name [options]

options:
    -h, --help show this help message and exit -f FILE, --file=FILE Variable used to specify a file on which the filter will be run. If no value is defined, no value will be filtered.

    -S SECOND, --second=SECOND Variable used to specify which second of logs should be displayed. If no value is defined, no value will be filtered.

    -M MINUTE, --miunte=MINUTE Variable used to specify which minute of logs should be displayed. If no value is defined, no value will be filtered.

    -H HOUR, --hour=HOUR Variable used to specify which seconds of logs should be displayed. If no value is defined, no value will be filtered.

    -d DAY, --day=DAY Variable used to specify which day of logs should be displayed. If no value is defined, no value will be filtered.

    -m MONTH, --month=MONTH Variable used to specify which mothn of logs should be displayed. If no value is defined, no value will be filtered

    -y YEAR, --year=YEAR Variable used to specify which year of logs should be displayed. If no value is defined, no value will be filtered.

    -e, --error Variable used to specify that olny ERROR logs should be displayed.

EOT
}

# if no arguments given
if test -z "$1"
then
    print_help
fi


# do with command line arguments
e=n
while test "x$1" != "x"
do
        case "$1" in
                -e|--error) e=y;;
                -h|--help) print_help shift;;
                -f|--file) set_file "$2"; shift;;
                -S|--second) set_second "$2"; shift;;
                -M|--minute) set_minute "$2"; shift;;
                -H|--hour) set_hour "$2"; shift;;
                -d|--day) set_day "$2"; shift;;
                -m|--month) set_month "$2"; shift;;
                -y|--year) set_year "$2"; shift;;
                -*) error_msg "bad option $1"; exit 1 ;;
                *) echo "arg: $1"
        esac
        shift
done

if [ ! -z "$file" ]; then
    while IFS= read -r line; do
        IFS='T|-|:|\\+' read -a log_line <<< "$line"
        #echo "${log_line[0]}" year
        # echo "${log_line[1]}" month
        # echo "${log_line[2]}" day
        # echo "${log_line[3]}" hour
        # echo "${log_line[4]}" minute
        # echo "${log_line[5]}" second
        # echo "${log_line[7]}"
        if [ ! -z "$year" ] && [ "${year}" != "${log_line[0]}" ]; then
            continue
        fi
        if [ ! -z "$month" ] && [ "${month}" != "${log_line[1]}" ]; then
            continue
        fi
        if [ ! -z "$day" ] && [ "${day}" != "${log_line[2]}" ]; then
            continue
        fi
        if [ ! -z "$hour" ] && [ "${hour}" != "${log_line[3]}" ]; then
            continue
        fi
        if [ ! -z "$minute" ] && [ "${minute}" != "${log_line[4]}" ]; then
            continue
        fi
        if [ ! -z "$second" ] && [ "${second}" != "${log_line[5]}" ]; then
            continue
        fi
        if [ "$e" = "y" ] && [[ ${log_line[7]} != *"ERROR"* ]]; then
            continue
        fi
        echo $line
    done < $file
fi