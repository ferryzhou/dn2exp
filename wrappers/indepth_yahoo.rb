#encoding: utf-8

require 'open-uri'
require 'nokogiri'
require 'date'
require 'json'

page_url = 'http://tech.cn.yahoo.com/shendu/'

doc = Nokogiri::HTML(open(page_url))

nitems = doc.search('ul.list_body li').collect do |item|
  nitem = Hash.new
  a = item.search('a').first
  nitem['link'] = a['href']
  nitem['title'] = a.content
  nitem['source'] = ''
  nitem['time'] = DateTime.strptime(item.search('span').first.content, '%Y%m%d')
  nitem
end

puts JSON.pretty_generate(nitems)
