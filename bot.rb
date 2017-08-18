#!/usr/bin/env ruby
#
#
require 'uri'
require 'net/http'
require 'json'
require './lib/greenbot'

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
  parse_response(response.read_body)
end

def get_reply(tone)
  response_map = Hash[
      "sadness" => ENV['SAD_MESSAGE'] || "I really understand how you feel",
      "joy" => ENV['JOY_MESSAGE'] || "Great, someone seems to be in a good mood",
      "disgust" => ENV['DISGUST_MESSAGE'] || "I understand how frustrating this might seem",
      "anger" => ENV['ANGER_MESSAGE'] || "Kindly be calm, we will resolve this I assure you",
      "fear" => ENV['FEAR_MESSAGE'] || "It is not as bad as it seems. Everything will be alright",
  ]
  return response_map[tone]
end


def parse_response(response)
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

  puts get_reply(current_emotional_tone['tone_id'])
end



PROMPT_1 = ENV['PROMPT_1'] || "How can we help you today?"
issue = note(PROMPT_1)

analyse_sentiment(issue)



