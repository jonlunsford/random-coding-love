%w(sinatra json nokogiri open-uri httparty).each do |lib|
  require lib
end

get '/' do
  parse_post
end

get '/slack' do
  doc = Nokogiri::HTML(open("http://thecodinglove.com/random"))
  text = doc.css(".post h3").first.text
  image = doc.css(".post .bodytype img")[0]['src']

  response = {
    attachments: [{
      pretext: text,
      image_url: image
    }],
    channel: params[:channel_name],
    username: "the_coding_love()",
    icon_emoji: ":space_invader:"
  }

  puts "!!!!!!!!!!!!!!!!!!!!!!!!!!"
  puts params
  puts "!!!!!!!!!!!!!!!!!!!!!!!!!!"
  puts HTTParty.post(ENV["SLACK_WEBHOOK"], body: { payload: response.to_json })
  puts "!!!!!!!!!!!!!!!!!!!!!!!!!!"
  puts response
  puts "!!!!!!!!!!!!!!!!!!!!!!!!!!"

  status 200
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
