require 'nokogiri'
require 'open-uri'
require 'ruby-try'
require './url/base.rb'
require './models/chart/base.rb'


charts = {}
2015.upto(2015) do |year|
  53.downto(1) do |target|
    charts[target] = []
    charts[target] << Chart::Base.fetch_collection("digital", target, year)
    charts[target] << Chart::Base.fetch_collection("download", target, year)
    charts[target] << Chart::Base.fetch_collection("streaming", target, year)
    charts[target] << Chart::Base.fetch_collection("bgm", target, year)
    charts[target] << Chart::Base.fetch_collection("mobile", target, year)
    charts[target] << Chart::Base.fetch_collection("karaoke", target, year)
    charts[target] << Chart::Base.fetch_collection("social", target, year)
    charts[target] = charts[target].flatten
  end
end

charts.each do |key, chart_collection|
  s = chart_collection.group_by{ |chart| [chart.year, chart.week, chart.name, chart.singer] }
  s.each do |group_key, values|
    digital = values.select{ |x| x.type == "digital" }.try(:first)
    download = values.select{ |x| x.type == "download" }.try(:first)
    streaming = values.select{ |x| x.type == "streaming" }.try(:first)
    bgm = values.select{ |x| x.type == "bgm" }.try(:first)
    mobile = values.select{ |x| x.type == "mobile" }.try(:first)
    karaoke = values.select{ |x| x.type == "karaoke" }.try(:first)
    social = values.select{ |x| x.type == "social" }.try(:first)

    # puts social
    puts "#{group_key[0]},#{group_key[1]},#{group_key[2]},#{group_key[3]},#{digital.try(:rank)},#{download.try(:rank)},#{download.try(:count)},#{streaming.try(:rank)},#{streaming.try(:count)},#{bgm.try(:rank)},#{mobile.try(:rank)},#{karaoke.try(:rank)},#{social.try(:rank)},#{social.try(:count)}"
  end
end
