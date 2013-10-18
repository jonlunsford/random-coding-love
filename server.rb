%w(sinatra json nokogiri open-uri).each do |lib|
  require lib
end

doc = Nokogiri::HTML(open("http://thecodinglove.com/random"))

get '/random' do
  content_type :json
  {:title => doc.css(".post h3").first.text, :image => doc.css(".post .bodytype img")[0]['src']}.to_json
end