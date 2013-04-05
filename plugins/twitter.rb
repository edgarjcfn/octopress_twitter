require 'twitter'

Twitter.configure do |config| 
     config.consumer_key =        "insert..."
     config.consumer_secret =     "your..."
     config.oauth_token =         "twitter app info..."
     config.oauth_token_secret =  "here."
end

twitter_user = 'edgarjcfn' 
num_tweets = 5
output_file = "./source/_includes/custom/asides/twitter.html"
input_file = "./source/_includes/custom/asides/twitter_input.html"

# Returns an HTML string of tweets with dates inside <p> tags
def get_tweets(screen_name, num_tweets)
	
	result = ""
    #Query num_tweets tweets from screen_name and create the HTML
    Twitter.user_timeline(screen_name, {"count" => num_tweets}).each do |tweet|
    	linkified = linkifyTweet(tweet.text)
    	result = result + "<li class=\"tweet\">
                           <span class=\"gentle\">#{linkified}</span>
                        </li>"
    end
    return result
end

def linkifyTweet(text)
  text = text.gsub(/(https?:\/\/)([\w\-:;?&=+.%#\/]+)/, '<a href="\1\2">\2</a>')
  text = text.gsub(/(^|\W)@(\w+)/, '\1<a href="https://twitter.com/\2">@\2</a>')
  text = text.gsub(/(^|\W)#(\w+)/, '\1<a href="https://search.twitter.com/search?q=%23\2">#\2</a>');

  return text
end


output = get_tweets(twitter_user, num_tweets)
text = File.read(input_file)
text = text.gsub(/da_tuitz/, output)
File.open(output_file, "w") {|f| f.puts(text) }

puts "Updated Twitter plugin"