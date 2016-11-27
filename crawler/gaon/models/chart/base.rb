module Chart
  class Base
    def initialize(chart, type, week, year)
      @rank = chart[:rank].to_i
      @name = chart[:name].strip
      @singer = chart[:singer].strip
      @count = chart[:count]
      @type = type
      @week = week
      @year = year
    end

    def to_s
      "rank: #{@rank}, name: #{@name}, singer: #{@singer}, count: #{@count}, type: #{@type}"
    end

    def week
      @week
    end

    def year
      @year
    end

    def inspect
      to_s
    end

    def name
      @name
    end

    def rank
      @rank
    end

    def singer
      @singer
    end

    def count
      @count
    end

    def type
      @type
    end

    def self.fetch_collection(chart_name, target, year)
      url = Url::Builder.new.get_chart_url(chart_name, target, year)
      charts = Nokogiri::HTML(open(url))
      data = []
      idx = 0
      charts.search('.ranking').each do |dom|
        rank = dom.search("span").try(:first).try(:content)
        rank ||= dom.content


        data[idx] ||= {}
        data[idx][:rank] = rank;
        idx += 1
      end

      idx = 0
      charts.search('.subject').each do |dom|
        name = dom.search("p").first['title']
        singer = dom.search("p").last['title'].split("|")[0].strip

        data[idx] ||= {}
        data[idx][:name] = name;
        data[idx][:singer] = singer;
        idx += 1
      end

      idx = 0
      charts.search('.count').each do |dom|
        count = dom.search("p").try(:first).try(:content)
        count ||=  dom.try(:content)

        data[idx] ||= {}
        data[idx][:count] = count.gsub(",", "").to_i;
        idx += 1
      end

      data.map{ |x| Chart::Base.new(x, chart_name, target, year) }
    end
  end
end
