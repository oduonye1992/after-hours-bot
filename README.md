

A simple bot for reporting things like pot holes, absent students and cranky waiters for greenbot. 

## Conversation Flow

1. This bot starts when someone sends it a message. 
2. The bot sends a greeting, should be something like "Welcome to the Barnstable DPW pot hole bot."
3. The bot sends a question to be answered, like. "Please tell us all about your pothole."
4. The bot starts listening for messages. After every message, it asks for more. 
5. Once the texter sends a single q, note taking mode will end.
6. The bot will then ask the texter if they want to be contacted directly. This behavior cannot be disabled. 
7. If they want to be contacted, the bot asks for who to ask for, and if there is another number to try.  
8. The conversation ends with two more prompts. 
  

```
#!/usr/bin/env ruby

```











  

```
require "./lib/greenbot.rb"
tell ENV['PROMPT_1']
issue = note(ENV['PROMPT_2'])
if confirm("Would you like someone to contact you?")
  contact_me = true
  contact_me.remember("contact_me")
  name = ask("When we call, who should we ask for?")
  name.remember("who_to_ask_for")
  if confirm("Is there another number we should try?")
    better_number = ask("Please enter that number with an area code")
    better_number.remember("better_number")
  end
else
  tell("No problem at all.")
end
tell ENV['PROMPT_3']
tell ENV['SIGNATURE']


```




