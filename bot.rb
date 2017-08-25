#!/usr/bin/env ruby
#
#
require 'uri'
require 'json'
require './lib/greenbot'
require 'date'

WEEKDAY_CLOSING_TIME = ENV['WEEKDAY_CLOSING_TIME'] || "07:00" 
WEEKEND_CLOSING_TIME = ENV['WEEKEND_CLOSING_TIME'] || "17:00"  
OFFICE_CLOSED_COMMENT = ENV['OFFICE_CLOSED_COMMENT'] || "Sorry, We are closed for the day"
NO_WEEKEND_HOURS = "none"
def isWeekday()
    today = Date.today
    return today.wday <= 5
end

def getFormattedTime(timeStr)
    currentTime = timeStr
    currentTime = currentTime.gsub(':', '')
    currentTime = currentTime.to_i
end

def isAfterWorkHours()
    if (!isWeekday())
        tmpStr = WEEKEND_CLOING_TIME.downcase
        if (tmpStr === NO_WEEKEND_HOURS)
            puts OFFICE_CLOSED_COMMENT
        end
    end
    currentTime = getFormattedTime(Time.now.strftime("%H:%M"))
    officeClosingTime = getFormattedTime(isWeekday() ? WEEKDAY_CLOSING_TIME : WEEKEND_CLOSING_TIME)
    return currentTime > officeClosingTime
end

if (isAfterWorkHours())
     puts OFFICE_CLOSED_COMMENT
end

