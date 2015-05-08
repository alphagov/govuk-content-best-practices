require_relative "../lib/crawler"

links_string = <<-LINKS
  https://www.gov.uk/example_link1
  https://www.gov.uk/example_link2
LINKS

Crawler.new(links_string.split("\n").map(&:strip)).run
