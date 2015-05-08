require 'nokogiri'
require 'open-uri'
require 'fileutils'

class Crawler
  attr_reader :links

  def initialize(links, persist_to: "snapshots")
    @links = links
    @persist_to = persist_to
  end

  def run
    links.each do |link|
      puts "Opening #{link}..."
      slug = link.split("/").last.split("?").first
      doc = open_url(link)
      parsed = Nokogiri::HTML(doc)
      relevant_content = parsed.at_css("#whitehall-wrapper") || parsed.at_css("#wrapper")
      if relevant_content
        template = File.open("template.html")
        templated_file = Nokogiri::XML(template)
        template.close
        templated_file.at_css("#placeholder").replace(relevant_content.to_s)

        filename = File.join(@persist_to, "#{slug}.html")
        puts "Applying the template to #{filename}"
        File.open(filename, 'w') { |file| file.write(templated_file.to_s) }
      else
        puts "** No relevant content found, skipping.**\n"
      end
    end
  end

private

  def open_url(url)
    open(link).read
  end
end

