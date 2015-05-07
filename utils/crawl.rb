require 'nokogiri'
require 'open-uri'
require 'fileutils'

links = <<-LINKS
  https://www.gov.uk/government/case-studies/turning-baths-neglected-riverside-into-an-exciting-new-community
  https://www.gov.uk/government/consultations/postgraduate-study-student-loans-and-other-support
  https://www.gov.uk/government/organisations/department-of-health/about
  https://www.gov.uk/government/organisations/ministry-of-defence/about/complaints-procedure
  https://www.gov.uk/search?q=DH+equality+and+diversity
  https://www.gov.uk/government/organisations/national-measurement-and-regulation-office/about/our-governance
  https://www.gov.uk/government/organisations/department-for-transport/about/our-energy-use
  https://www.gov.uk/government/organisations/natural-england/about/media-enquiries
  https://www.gov.uk/government/publications/decc-information-charter
  https://www.gov.uk/government/organisations/civil-nuclear-constabulary/about/procurement
  https://www.gov.uk/government/organisations/department-for-business-innovation-skills/about/publication-scheme
  https://www.gov.uk/government/organisations/environment-agency/about/research
  https://www.gov.uk/government/organisations/department-for-transport/about/social-media-use
  https://www.gov.uk/government/organisations/environment-agency/about/recruitment
  https://www.gov.uk/apply-for-a-tier-4-sponsor-licence
  https://www.gov.uk/government/collections/national-driving-and-riding-standards
  https://www.gov.uk/government/news/cde-innovation-network-event-13-january-2015-london
  https://www.gov.uk/government/collections/academy-for-justice-commissioning-events
  https://www.gov.uk/government/groups/bureaucracy-reference-group
  https://www.gov.uk/guidance/convert-to-an-academy-information-for-schools
  https://www.gov.uk/government/news/improving-food-in-hospitals-and-schools
  https://www.gov.uk/government/news/public-approval-for-driving-limits-for-16-drugs
  https://www.gov.uk/government/news/new-frank-adverts-mark-tenth-anniversary--2
  https://www.gov.uk/government/organisations/environment-agency
  https://www.gov.uk/government/people/will-cavendish
  https://www.gov.uk/government/ministers/secretary-of-state-for-transport
  https://www.gov.uk/government/publications/skills-funding-agency-annual-report-and-accounts-2013-to-2014
  https://www.gov.uk/government/publications/letter-to-councillor-rob-anderson-slough-childrens-services
  https://www.gov.uk/government/publications/fire-and-rescue-bulletin-432014
  https://www.gov.uk/government/publications/application-to-extend-your-stay-in-the-uk-as-a-tier-1-investor
  https://www.gov.uk/government/publications/number-of-ex-regular-service-personnel-in-fr20
  https://www.gov.uk/government/publications/car-and-small-van-driving-syllabus
  https://www.gov.uk/government/publications/right-to-request-flexible-working-impact-assessment-revised-cost-to-business
  https://www.gov.uk/government/publications/health-working-group-report-on-child-sexual-exploitation
  https://www.gov.uk/government/statistics/cattle-sheep-and-pig-slaughter
  https://www.gov.uk/government/publications/walton-farms-limited-application-made-to-abstract-take-water
  https://www.gov.uk/government/publications/strategy-for-dealing-with-safeguarding-issues-in-charities
  https://www.gov.uk/government/publications/a-guide-to-immunisations-for-babies-up-to-13-months-of-age
  https://www.gov.uk/government/publications/gce-qualification-level-conditions-and-requirements
  https://www.gov.uk/government/publications/adoption-and-fostering-understanding-attitudes-motivations-and-barriers
  https://www.gov.uk/government/publications/keeping-children-safe-in-education--2
  https://www.gov.uk/government/publications/cabinet-office-special-advisers-gifts-hospitality-and-meetings-april-to-june-2014
  https://www.gov.uk/government/speeches/lord-mcnally-s-speaking-note-for-westminster-legal-policy-forum-event
  https://www.gov.uk/business-tax/corporation-tax
  https://www.gov.uk/government/topical-events/budget-2014
  https://www.gov.uk/government/priority/council-of-europe-promoting-human-rights-protection
LINKS

links.split("\n").map(&:strip).each do |link|
  puts "Opening #{link}..."
  slug = link.split("/").last.split("?").first.gsub("/", "-")
  doc = open(link).read
  parsed = Nokogiri::HTML(doc)
  relevant_content = parsed.at_css("#whitehall-wrapper") || parsed.at_css("#wrapper")
  if relevant_content
    filename = "snapshots/#{slug}.html"
    puts "Applying the template to #{filename}"
    template = File.open("template.html")
    templated_file = Nokogiri::XML(template)
    template.close
    templated_file.at_css("#placeholder").replace(relevant_content.to_s)
    File.open(filename, 'w') { |file| file.write(templated_file.to_s) }
  else
    puts "** No relevant content found, skipping.**\n"
  end
end

puts "Done"
