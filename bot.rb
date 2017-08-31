#!/usr/bin/env ruby
#
#
require 'uri'
require 'json'
require './lib/greenbot'
require 'date'

#WEEKDAY_START_TIME = ENV['WEEKDAY_START_TIME'] || "21:00"
#WEEKDAY_CLOSING_TIME = ENV['WEEKDAY_CLOSING_TIME'] || "22:00"

#WEEKEND_START_TIME = ENV['WEEKEND_START_TIME'] || "15:00"
#WEEKEND_CLOSING_TIME = ENV['WEEKEND_CLOSING_TIME'] || "17:00"
#OFFICE_TIMEZONE = ENV['OFFICE_TIMEZONE'] || "+0:00"
#OFFICE_CLOSED_COMMENT = ENV['OFFICE_CLOSED_COMMENT'] || "Sorry, We are closed for the day"
#NO_WEEKEND_HOURS = "none"

#def isWeekday()
    #today = Date.today
    #return today.wday <= 5
#end

#def getFormattedTime(timeStr)
    #currentTime = timeStr
    #currentTime = currentTime.split(':')
    #return (currentTime[0].to_i * 60) + currentTime[1].to_i
#end

#def getFormattedTimeWithTimezone(time, timezone)
    #operation = timezone[0]
    #if (operation != "+" || operation != "-")
        #return getFormattedTime(time)
    #end
    #timezone[0] = ''
    #timezone = getFormattedTime(timezone)
    #time = getFormattedTime(time)
    #return operation == "+" ? time + timezone : time - timezone
#end

#def isTeamWorkHours()
    #if (!isWeekday())
        #tmpStr = WEEKEND_CLOSING_TIME.downcase
        #if (tmpStr === NO_WEEKEND_HOURS)
            #return true
        #end
    #end
    #currentTime = getFormattedTime(Time.now.utc.strftime("%H:%M"))

    #_officeStartTime = isWeekday() ? WEEKDAY_START_TIME : WEEKEND_START_TIME;
    #officeStartTime = getFormattedTimeWithTimezone(_officeStartTime, OFFICE_TIMEZONE)

    #officeCloseTime = isWeekday() ? WEEKDAY_CLOSING_TIME : WEEKEND_CLOSING_TIME;
    #officeClosingTime = getFormattedTimeWithTimezone(officeCloseTime, OFFICE_TIMEZONE)
    #return currentTime < officeClosingTime && currentTime > officeStartTime
#end

#/*if (!isTeamWorkHours())
     #puts OFFICE_CLOSED_COMMENT
     #puts "{{end_session}}"
#end*/
put "{{end_session}}"

