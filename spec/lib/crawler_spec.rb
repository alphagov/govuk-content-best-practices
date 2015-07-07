require_relative '../../lib/crawler'

RSpec.describe Crawler do
  it "applies the template to a gov.uk page from a url and saves it" do
    crawler = described_class.new(["http://gov.uk/something"], persist_to: "spec/fixtures")

    expect(crawler).to receive(:open_url).and_return "<html><div id=\"wrapper\">Relevant content</div></html>"

    crawler.run

    document = File.open("spec/fixtures/something.html").read
    expect(document).to include %q(<div id="wrapper">Relevant content</div>)
    FileUtils.rm("spec/fixtures/something.html")
  end

  it "transforms the query string and keeps it as part of the slug to avoid duplicates for generic terms like 'search' etc" do
    crawler = described_class.new(["http://gov.uk/search?query=1&sort=asc"], persist_to: "spec/fixtures")

    expect(crawler).to receive(:open_url).and_return "<html><div id=\"wrapper\">Relevant content</div></html>"

    crawler.run

    expect(File.exists?("spec/fixtures/search_query_1_sort_asc.html")).to eq true
    FileUtils.rm("spec/fixtures/search_query_1_sort_asc.html")
  end

  it "transforms full path to a filename to avoid duplicates" do
    crawler = described_class.new(["http://gov.uk/department/stats"], persist_to: "spec/fixtures")

    expect(crawler).to receive(:open_url).and_return "<html><div id=\"wrapper\">Relevant content</div></html>"

    crawler.run

    expect(File.exists?("spec/fixtures/department-stats.html")).to eq true
    FileUtils.rm("spec/fixtures/department-stats.html")
  end
end
