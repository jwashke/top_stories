require 'faraday'
require 'json'

class TopStories
  def initialize
    @api_key = File.read('key.txt').chomp
    @section = ARGV[0]
  end

  def get_top_stories
    response = Faraday.get("http://api.nytimes.com/svc/topstories/v1/#{@section}.json?api-key=#{@api_key}")
    raw_data = response.body
    data = JSON.parse(raw_data)
    stories =  data["results"]
    format_and_print(stories)
  end

  def format_and_print(stories)
    stories.each do |story|
      puts "Title: #{story["title"]}"
      puts "#{story["byline"]}"
      puts "Date published: #{story["published_date"]}"
      puts "#{story["abstract"]}"
      puts "URL: #{story["url"]}"
    end
  end

end

if __FILE__ == $0
  ts = TopStories.new
  ts.get_top_stories
end
