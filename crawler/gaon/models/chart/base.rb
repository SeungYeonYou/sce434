module Chart
  class Base
    def initialize(chart, type)
      @rank = chart[:rank]
      @name = chart[:name]
      @singer = chart[:singer]
      @count = chart[:count]
      @type = type
    end

    def to_s
      "rank: #{@rank}, name: #{@name}, singer: #{@singer}, count: #{@count}, type: #{@type}"
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

    def self.fetch_collection(chart_name, target)
      url = Url::Builder.new.get_chart_url(chart_name, target)
      charts = Nokogiri::HTML(open(url))
      data = []
      idx = 0
      charts.search('.ranking').each do |ranking|
        rank = ranking.search("span").try(:first).try(:content)
        rank ||= ranking.content


        data[idx] ||= {}
        data[idx][:rank] = rank;
        idx += 1
      end

      idx = 0
      charts.search('.subject').each do |subject|
        name = subject.search("p").first['title']
        singer = subject.search("p").last['title']

        data[idx] ||= {}
        data[idx][:name] = name;
        data[idx][:singer] = singer;
        idx += 1
      end

      idx = 0
      charts.search('.count p').each do |count|
        count = Integer(count.content.gsub(",", ""))

        data[idx] ||= {}
        data[idx][:count] = count;
        idx += 1
      end

      data.map{ |x| Chart::Base.new(x, chart_name) }
    end
  end
end
