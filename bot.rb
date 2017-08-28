#!/usr/bin/env ruby
#
#
require 'uri'
require 'json'
require './lib/greenbot'
require 'date'

WEEKDAY_CLOSING_TIME = ENV['WEEKDAY_CLOSING_TIME'] || "07:00"
WEEKEND_CLOSING_TIME = ENV['WEEKEND_CLOSING_TIME'] || "17:00"
OFFICE_TIMEZONE = ENV['OFFICE_TIMEZONE'] || "+0:00"
OFFICE_CLOSED_COMMENT = ENV['OFFICE_CLOSED_COMMENT'] || "Sorry, We are closed for the day"
NO_WEEKEND_HOURS = "none"

def isWeekday()
    today = Date.today
    return today.wday <= 5
end

def getFormattedTime(timeStr)
    currentTime = timeStr
    currentTime = currentTime.split(':')
    return (currentTime[0].to_i * 60) + currentTime[1].to_i
end

def getFormattedTimeWithTimezone(time, timezone)
    operation = timezone[0]
    if (operation != "+" || operation != "-")
        return getFormattedTime(time)
    end
    timezone[0] = ''
    timezone = getFormattedTime(timezone)
    time = getFormattedTime(time)
    return operation == "+" ? time + timezone : time - timezone
end

def isAfterWorkHours()
    if (!isWeekday())
        tmpStr = WEEKEND_CLOSING_TIME.downcase
        if (tmpStr === NO_WEEKEND_HOURS)
            return true
        end
    end
    currentTime = getFormattedTime(Time.now.utc.strftime("%H:%M"))
    officeTime = isWeekday() ? WEEKDAY_CLOSING_TIME : WEEKEND_CLOSING_TIME;
    officeClosingTime = getFormattedTimeWithTimezone(officeTime, OFFICE_TIMEZONE)
    return currentTime > officeClosingTime
end

if (isAfterWorkHours())
     puts OFFICE_CLOSED_COMMENT
end

