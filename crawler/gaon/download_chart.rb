require 'nokogiri'
require 'open-uri'
require 'ruby-try'

# 주/월/연 [targetTime, hitYear, termGbn] 3가지로 얻어올 수 있음
# 타이틀
# digital, download, streaming, mobile, album, 노래방
# 다운로드 주간
download_chart = Nokogiri::HTML(open('http://gaonchart.co.kr/main/section/chart/online.gaon?nationGbn=T&serviceGbn=S1020'))

data = []
idx = 0
download_chart.search('.ranking').each do |ranking|
  rank = ranking.search("span").try(:first).try(:content)
  rank ||= ranking.content


  data[idx] ||= {}
  data[idx][:rank] = rank;
  idx += 1
end

idx = 0
download_chart.search('.subject').each do |subject|
  name = subject.search("p").first['title']
  singer = subject.search("p").last['title']

  data[idx] ||= {}
  data[idx][:name] = name;
  data[idx][:singer] = singer;
  idx += 1
end

idx = 0
download_chart.search('.count p').each do |count|
  download_count = Integer(count.content.gsub(",", ""))

  data[idx] ||= {}
  data[idx][:download_count] = download_count;
  idx += 1
end

puts data
