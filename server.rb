require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'eat'
require 'json'

get '/hi' do
  "Hello!"
end

get '/slickdeals' do
  data = []
  doc = Nokogiri::HTML(eat('http://slickdeals.net/'))
  
  doc.search('a[id^=deal_header]').each do |link| 
    title = ""
    link.search('h3').each do |h| 
      title = h.content.strip.split.join(" ")
    end
    
    data << {:title => title, :link => link["href"]} if title.length != 0
  end
  
  data.to_json
end

get '/edmw' do
  data = []
  doc = Nokogiri::HTML(eat('http://forums.hardwarezone.com.sg/forumdisplay.php?f=16', :timeout => 5))
  
  doc.search('a[id^=thread_title]').each do |link| 
    data << {:title => link.content.strip, :link => "http://forums.hardwarezone.com.sg/" + link["href"].gsub(/(s=[^\&]+)/, "")}
  end
  
  data.to_json
end