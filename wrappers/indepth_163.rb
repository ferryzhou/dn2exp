#encoding: utf-8

require 'open-uri'
require 'nokogiri'
require 'date'
require 'json'

page_url = 'http://tech.163.com/special/000925CD/Cover.html'
content = open(page_url).read # need read first, otherwise content will be truncated
doc = Nokogiri::HTML(content)
#doc = Nokogiri::HTML(open(page_url))

nitems = Array.new
doc.search('div.group.clearfix').each do |group|
  source = group.search('h5').first.content
  group.search('ul li').each do |item|
    nitem = Hash.new
    a = item.search('a').first
    nitem['link'] = a['href']
    nitem['title'] = a.content
    nitem['source'] = source
    nitem['time'] = DateTime.parse(item.search('span').first.content)
    nitems.push(nitem)
  end
end

puts JSON.pretty_generate(nitems)

