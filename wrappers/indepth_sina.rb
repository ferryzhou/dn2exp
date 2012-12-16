#encoding: utf-8

require 'open-uri'
require 'nokogiri'
require 'date'
require 'json'

page_url = 'http://roll.tech.sina.com.cn/iframe_famous/index.shtml'

doc = Nokogiri::HTML(open(page_url))

nitems = doc.search('ul li').collect do |item|
  nitem = Hash.new
  a = item.search('a').first
  nitem['link'] = a['href']
  nitem['title'] = a.content
  span_segs = item.search('span').first.content.split(' ')
  nitem['source'] = span_segs.first.gsub(/[(《》杂志]/, '')
  asegs = a['href'].split('/')
  nitem['time'] = DateTime.parse(asegs[-2] + 'T' + span_segs.last)
  nitem
end

puts JSON.pretty_generate(nitems)
