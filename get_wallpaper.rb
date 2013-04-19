#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

date = Date.today.strftime('%y%m%d')

apod_base_uri = "http://apod.nasa.gov/apod/"
apod_uri = apod_base_uri + "ap" + date + ".html" 

doc = Nokogiri::HTML(open(apod_uri))

img_uri = apod_base_uri + doc.css('img')[0]['src']

local_file_path= "/home/jeremy/wallpapers/apod-wallpaper"+date+".jpg"

open(img_uri) {|f|
   File.open(local_file_path,"wb") do |file|
     file.puts f.read
   end
}

`gsettings set org.gnome.desktop.background picture-uri file://#{local_file_path}`
`gsettings set org.gnome.desktop.background picture-options centered`
`gsettings set org.gnome.desktop.background primary-color black`