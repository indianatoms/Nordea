#!/usr/bin/env python3

import optparse
from os import terminal_size
import re

def get_arguments():
    parser = optparse.OptionParser()
    parser.add_option("-f","--file", dest="file", help="Variable used to specify a file on which the filter will be run. If no value is defined, no value will be filtered.")
    parser.add_option("-S","--second", dest="second", help="Variable used to specify which second of logs should be displayed. If no value is defined, no value will be filtered.")
    parser.add_option("-M","--miunte", dest="minute", help="Variable used to specify which minute of logs should be displayed. If no value is defined, no value will be filtered.")
    parser.add_option("-H","--hour", dest="hour", help="Variable used to specify which seconds of logs should be displayed. If no value is defined, no value will be filtered.")
    parser.add_option("-d","--day", dest="day", help="Variable used to specify which day of logs should be displayed. If no value is defined, no value will be filtered.")
    parser.add_option("-m","--month", dest="month", help="Variable used to specify which mothn of logs should be displayed. If no value is defined, no value will be filtered")
    parser.add_option("-y","--year", dest="year", help="Variable used to specify which year of logs should be displayed. If no value is defined, no value will be filtered.")
    parser.add_option("-e","--error", dest="error", action="store_true", default=False, help="Variable used to specify that olny ERROR logs should be displayed.")

    return parser.parse_args()

def read_file(filename):
    with open(filename) as file_in:
        lines = []
        for line in file_in:
            lines.append(line.strip()) #strip '\n' at the end of the file 
    return lines


def filter_lines(lines,second,minute,hour,day,month,year,error):
    for line in lines:
        log_year,log_month,log_day,log_hour,log_minute,log_second,log_error = re.split('T|-|:|\\+',line,6) #unbox and split line
        if year != None and log_year != year:
            continue
        if month != None and log_month != month:
            continue
        if day != None and log_day != day:
            continue
        if hour != None and log_hour != hour:
            continue
        if minute != None and log_minute != minute:
            continue
        if second != None and log_second != second:
            continue
        if error == True and "ERROR" not in log_error:
            continue
        print(line)



if __name__ == '__main__':
    (options, arguments) = get_arguments()
    if not options.file:  # filename is not given
        print('Specify a file. Type -h for help.')
    else:
        fileLines = read_file(options.file)
        filteredLines = filter_lines(fileLines, options.second, options.minute, options.hour, options.day, options.month, options.year, options.error)