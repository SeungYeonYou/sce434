require 'nokogiri'
require 'open-uri'
require 'ruby-try'
require './url/base.rb'
require './models/chart/base.rb'

charts = {}
47.downto(1) do |target|
  charts[target] = []
  charts[target] << Chart::Base.fetch_collection("digital", target)
  charts[target] << Chart::Base.fetch_collection("download", target)
  charts[target] << Chart::Base.fetch_collection("streaming", target)
  # charts[target] << Chart::Base.fetch_collection("bgm", target)
  # charts[target] << Chart::Base.fetch_collection("mobile", target)
  # charts[target] << Chart::Base.fetch_collection("karaoke", target)
  # charts[target] << Chart::Base.fetch_collection("album", target)
  charts[target] = charts[target].flatten
end

cnt = 0
charts.each do |key, chart_collection|
  s = chart_collection.group_by{|chart| chart.name}
  b = s.map{ |key, value| value }.select{ |x| x.map(&:type).uniq.length >= 3 }.length
  cnt += b
  puts b
end

puts "total: " + cnt.to_s
