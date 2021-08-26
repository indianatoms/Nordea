# Nordea Recuritment Task

## Prerequisites

1. Python3 (https://www.python.org/downloads/)

## Make /filter.py executable
```
chmod +x filter.py
```

## Usage 
Usage: filter.py [options]

Options:
  -h, --help            show this help message and exit
  -f FILE, --file=FILE  Variable used to specify a file on which the filter
                        will be run. If no value is defined, no value will be
                        filtered.
  -S SECOND, --second=SECOND
                        Variable used to specify which second of logs should
                        be displayed. If no value is defined, no value will be
                        filtered.
  -M MINUTE, --miunte=MINUTE
                        Variable used to specify which minute of logs should
                        be displayed. If no value is defined, no value will be
                        filtered.
  -H HOUR, --hour=HOUR  Variable used to specify which seconds of logs should
                        be displayed. If no value is defined, no value will be
                        filtered.
  -d DAY, --day=DAY     Variable used to specify which day of logs should be
                        displayed. If no value is defined, no value will be
                        filtered.
  -m MONTH, --month=MONTH
                        Variable used to specify which mothn of logs should be
                        displayed. If no value is defined, no value will be
                        filtered
  -y YEAR, --year=YEAR  Variable used to specify which year of logs should be
                        displayed. If no value is defined, no value will be
                        filtered.
  -e, --error           Variable used to specify that olny ERROR logs should
                        be displayed.

## Example usage based on log.txt file

Filter only error logs with minute value equal to 29
```
./filter.py -f log.txt -M 29 -e
```

Filter all logs with year value equal to 2020, month value equal to 08, day value equal to 12 and hour value equal to 19.
```
./filter.py -f log.txt -y 2020 -m 08 -d 12 -H 19
```

Filter all logs with minute value equal to 29 and second value equal to 24.
```
./filter.py -f log.txt -M 29 -S 24
```

### Assumptions
In this task I have assumed that: all logs are following the ISO 8601 date and time structure, the second element is responsible for defining if the log is and error log, the last and third log element is holding the actual log message.
Due to the fact that we are following ISO 8601 standard when user is defining month, day, hour, minute or second sigle decimal digits need to have 0 as a prefix.
Correct form
```
./filter.py -f log.txt -M 09 -e
``` 
Invalid form
```
./filter.py -f log.txt -M 9 -e
``` 
Notice that after -M 09 has changed to 9.
