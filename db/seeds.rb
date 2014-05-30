# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Organization.destroy_all
Tag.destroy_all

tags = [
  'Human Rights', 'Children', 'Youth', 'Justice', 'Legal', 'Seattle', 'Community', 'Animals', 'Education'
]

tags.map! do |name|
  tag = Tag.new(name: name)
  tag.save!
  tag
end

organizations = [ {
    :name => 'Family Law CASA of King County',
    :description => 'Family Law CASA is a non-profit organization focusing on the needs of children in high risk custody cases in King County. Solely funded by private sources, Family Law CASA provides a vital service in our community by offering children an objective, dedicated representative - at no charge. Our dedicated volunteers provide comprehensive, timely reports to family law commissioners and judges, so they can make the best informed custody decisions for these children.',
    :website => 'http://www.familylawcasa.org',
    :tags => [ tags[0], tags[1], tags[2], tags[3], tags[4]]
  },
  {
    name: 'Seattle Center Foundation',
    description: "Since 1977, Seattle Center Foundation has worked with Seattle Center to reflect the 1962 World's Fair's mission of inspiration, innovation and imagination. With the Foundation's help, Seattle's premier urban park has been able to celebrate it's iconic past and create new cultural centers including the Marion Oliver McCaw Hall, International Fountain and Fisher Pavilion.",
    website: 'http://www.seattlecenter.org',
    tags: [ tags[1], tags[2], tags[5], tags[6] ]
  },
  {
    name: 'Kitsap Humane Society',
    description: "The Kitsap Humane Society is an open-admission animal shelter that maintains a 94% lives-saved rate. KHS rehomes over 4,000 companion animals per year through adoptions. KHS volunteers donate over 30,000 hours per year helping shelter animals!",
    website: 'http://www.kitsap-humane.org',
    tags: [ tags[7], tags[8], tags[6] ]
  },
  {
    name: "EvergreenHealth",
    description: "EvergreenHealth is a community-based health care organization serving more that 400,000 people throughout northern King and southern Snohomish counties in Washington state. Volunteers are needed to serve in the hospital and in the hospice program.",
    website: "http://www.evergreenhealthcare.org",
    tags: [ tags[6], tags[3], tags[8] ]
  },
  {
    :name => 'Family Law CASA of Metropol',
    :description => 'Family Law CASA is a non-profit organization focusing on the needs of children in high risk custody cases in King County. Solely funded by private sources, Family Law CASA provides a vital service in our community by offering children an objective, dedicated representative - at no charge. Our dedicated volunteers provide comprehensive, timely reports to family law commissioners and judges, so they can make the best informed custody decisions for these children.',
    :website => 'http://www.familylawcasa.org',
    :tags => [ tags[0], tags[1], tags[2], tags[3], tags[4]]
  },
  {
    name: 'Seattle Center Foundation Double',
    description: "Since 1977, Seattle Center Foundation has worked with Seattle Center to reflect the 1962 World's Fair's mission of inspiration, innovation and imagination. With the Foundation's help, Seattle's premier urban park has been able to celebrate it's iconic past and create new cultural centers including the Marion Oliver McCaw Hall, International Fountain and Fisher Pavilion.",
    website: 'http://www.seattlecenter.org',
    tags: [ tags[1], tags[2], tags[5], tags[6] ]
  },
  {
    name: 'Sochi Humane Society',
    description: "The Kitsap Humane Society is an open-admission animal shelter that maintains a 94% lives-saved rate. KHS rehomes over 4,000 companion animals per year through adoptions. KHS volunteers donate over 30,000 hours per year helping shelter animals!",
    website: 'http://www.kitsap-humane.org',
    tags: [ tags[7], tags[8], tags[6] ]
  },
  {
    name: "MasterChef Foundation",
    description: "EvergreenHealth is a community-based health care organization serving more that 400,000 people throughout northern King and southern Snohomish counties in Washington state. Volunteers are needed to serve in the hospital and in the hospice program.",
    website: "http://www.evergreenhealthcare.org",
    tags: [ tags[6], tags[3], tags[8] ]
  }
]

organizations.map! do |organization|
  org = Organization.new organization
  org.save!
  org
end
