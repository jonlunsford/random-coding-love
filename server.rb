%w(sinatra json nokogiri open-uri dotenv slack-ruby-client).each do |lib|
  require lib
end

get '/' do
  parse_post
end

post '/' do
return status 200 unless params[:token] == ENV["slack_token"]

@channel_id = params[:channel_id]
@channel_name = params[:channel_name]

#token=NLreG1DWX3wl8zdmD1aUQM1z
#team_id=T0001
#team_domain=example
#channel_id=C2147483705
#channel_name=test
#user_id=U2147483697
#user_name=Steve
#command=/weather
#text=94070



end

get '/random' do
  parse_post
end

get '/callback' do
  puts params
end

def parse_post
  doc = Nokogiri::HTML(open("http://thecodinglove.com/random"))

  content_type :json
  {:title => doc.css(".post h3").first.text, :image => doc.css(".post .bodytype img")[0]['src']}.to_json
end
