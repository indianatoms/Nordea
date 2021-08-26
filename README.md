# Nordea Recuritment Task

## Prerequisites

1. Python3 (https://www.python.org/downloads/)

## Make /filter.py executable
```
chmod +x filter.py
```

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