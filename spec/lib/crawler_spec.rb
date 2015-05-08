require_relative '../../lib/crawler'

RSpec.describe Crawler do
  let(:crawler){ described_class.new(["http://gov.uk/something"], persist_to: "spec/fixtures")}

  after{ FileUtils.rm("spec/fixtures/something.html")}

  it "applies the template to a gov.uk page from a url and saves it" do
    expect(crawler).to receive(:open_url).and_return "<html><div id=\"wrapper\">Relevant content</div></html>"

    crawler.run

    document = File.open("spec/fixtures/something.html").read
    expect(document).to include %q(<div id="wrapper">Relevant content</div>)
  end
end
