require 'nokogiri'
require 'open-uri'
require 'ruby-try'

streaming_chart = Nokogiri::HTML(open('http://gaonchart.co.kr/main/section/chart/online.gaon?nationGbn=T&serviceGbn=S1040'))
data = []
idx = 0
streaming_chart.search('.ranking').each do |ranking|
  rank = ranking.search("span").try(:first).try(:content)
  rank ||= ranking.content


  data[idx] ||= {}
  data[idx][:rank] = rank;
  idx += 1
end

idx = 0
streaming_chart.search('.subject').each do |subject|
  name = subject.search("p").first['title']
  singer = subject.search("p").last['title']

  data[idx] ||= {}
  data[idx][:name] = name;
  data[idx][:singer] = singer;
  idx += 1
end

idx = 0
streaming_chart.search('.count p').each do |count|
  download_count = Integer(count.content.gsub(",", ""))

  data[idx] ||= {}
  data[idx][:download_count] = download_count;
  idx += 1
end
