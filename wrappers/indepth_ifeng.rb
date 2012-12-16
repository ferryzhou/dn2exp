#encoding: utf-8

require 'open-uri'
require 'nokogiri'
require 'date'
require 'json'

page_url = 'http://tech.ifeng.com/magazine/'

doc = Nokogiri::HTML(open(page_url))

nitems = doc.search('div.blockL ul.newsList.f14 li').collect do |item|
  nitem = Hash.new
  a = item.search('a').first
  nitem['link'] = a['href']
  asegs = a.content.split(']')
  nitem['source'] = asegs.first.gsub(/\[/, '')
  nitem['title'] = asegs.last.strip
  nitem['time'] = DateTime.parse(item.search('span').first.content)
  nitem
end

puts JSON.pretty_generate(nitems)
