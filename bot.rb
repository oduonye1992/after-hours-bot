#!/usr/bin/env ruby
#
#
require 'uri'
require 'net/http'
require 'json'
require './lib/greenbot'

require 'mail'

Mail.defaults do
  delivery_method :smtp, { :address   => ENV['MAIL_ADDRESS'],
                           :port      => ENV['MAIL_PORT'],
                           :user_name => ENV['MAIL_USERNAME'],
                           :domain    => ENV['MAIL_DOMAIN'],
                           :password  => ENV['MAIL_PASSWORD'], 
                           :authentication => 'plain',
                           :enable_starttls_auto => true }
end


def analyse_sentiment(text)
  url = URI("https://tone-analyzer-demo.mybluemix.net/api/tone")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Post.new(url)
  request["content-type"] = 'application/x-www-form-urlencoded'
  request["cache-control"] = 'no-cache'
  request.body = "text=#{text}"
  response = http.request(request)
  return parse_response(response.read_body)
end

def angry?(messages)
 tone = analyse_sentiment(messages)
 if tone['tone_id'] == "anger"
   return true
 else 
   return false
 end
end


def parse_response(response)
  puts response
  response = JSON.parse(response)
  emotional_state_index = 0
  emotional_tone_list = response['document_tone']['tone_categories'][emotional_state_index]['tones'];
  current_emotional_tone = emotional_tone_list[0];
  $i = 1
  while $i < emotional_tone_list.length  do
    if emotional_tone_list[$i]['score'] > current_emotional_tone['score']
      current_emotional_tone = emotional_tone_list[$i]
    end
    $i += 1
  end
  return current_emotional_tone
end

# puts get_reply(current_emotional_tone['tone_id'])


#PROMPT_1 = ENV['PROMPT_1'] || "How can we help you today?"
#issue = note(PROMPT_1)

def send_notification(messages, email)
  puts "Someone is angry"
  email = EMAILS[0]
  _from, _to = 'bot@green-bot.com', email

  Mail.deliver do
    to _to
    from _from
    subject 'The customer seems angry based on the messages bellow'
    text_part do
      body messages
    end
  end
end


#analyse_sentiment(issue)
messages = ""

THRESHOLD = ENV['ANALYSIS_THRESHOLD'].to_i || 50
EMAILS = ENV['EMAILS'].split(",")
email = EMAILS[0]

while true
  message = gets
  messages += message
  if(messages.length >= THRESHOLD)
    puts "message length now #{messages.length}"
    send_notification(messages, email) if angry?(messages)
    messages = ""
  end
end

