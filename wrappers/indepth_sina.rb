#encoding: utf-8

require 'open-uri'
require 'nokogiri'
require 'date'

page_url = 'http://roll.tech.sina.com.cn/iframe_famous/index.shtml'

doc = Nokogiri::HTML(open(page_url))

doc.search('ul li').each do |item|
  a = item.search('a').first
  p a['href']
  p a.content
  span_segs = item.search('span').first.content.split(' ')
  p span_segs.gsub(/[(《》杂志]/, '')
  asegs = a['href'].split('/')
  t = DateTime.parse(asegs[-2] + 'T' + span_segs.last)
  p t
end


