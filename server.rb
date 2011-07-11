require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'json'

get '/hi' do
  "Hello!"
end

get '/slickdeals' do
  data = []
  doc = Nokogiri::HTML(open('http://slickdeals.net/'))
  
  doc.search('a[id^=deal_header]').each do |link| 
    title = ""
    link.search('h3').each do |h| 
      title = h.content.strip.split.join(" ")
    end
    
    data << {:title => title, :link => link["href"]} if title.length != 0
  end
  
  data.to_json
end

