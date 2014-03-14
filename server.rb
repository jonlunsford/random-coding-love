%w(sinatra json nokogiri open-uri).each do |lib|
  require lib
end


get '/' do
  doc = Nokogiri::HTML(open("http://thecodinglove.com/random"))
  
  content_type :json
  {:title => doc.css(".post h3").first.text, :image => doc.css(".post .bodytype img")[0]['src']}.to_json
end

get "/callback" do
  puts params
end