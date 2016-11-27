require 'uri'

module Url
  class Builder
    def self.root_url
      "http://gaonchart.co.kr"
    end

    def initialize(opts = {})
    end

    def get_chart_path(chart)
      case chart
      when "digital" then "/main/section/chart/online.gaon?nationGbn=T&serviceGbn=ALL"
      when "download" then "/main/section/chart/online.gaon?nationGbn=T&serviceGbn=S1020"
      when "streaming" then "/main/section/chart/online.gaon?nationGbn=T&serviceGbn=S1040"
      when "bgm" then "/main/section/chart/online.gaon?nationGbn=T&serviceGbn=S1060"
      when "mobile" then "/main/section/chart/mobile.gaon?nationGbn=T&serviceGbn=S2020"
      when "album" then "/main/section/chart/album.gaon?nationGbn=T"
      when "karaoke" then "/main/section/chart/karaoke.gaon?nationGbn=T"
      when "social" then "/main/section/chart/social.gaon?nationGbn=S"
      else
        raise ArgumentError.new("Cannot supported argument")
      end
    end

    def get_chart_url(chart, target, year = 2016, term = "week")
      add_query = URI.encode_www_form([["targetTime", target], ["hitYear", year], ["termGbn", term]])
      URI("#{Builder.root_url}#{get_chart_path(chart)}&#{add_query}")
    end
  end
end
