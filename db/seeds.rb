# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def generate_one(type)
  case type
  when :word
    Faker::Lorem.word
  when :email
    Faker::Internet.email
  else
    raise "Unknown type to generate: #{type}"
  end
end

def unique_generate(count, type)
  set = Set.new

  while(set.count < count) do
    set << generate_one(type)
  end

  set
end

def release_all
  User.destroy_all
  Group.destroy_all
  Membership.destroy_all
  Organization.destroy_all
  Tag.destroy_all
  Message.destroy_all
  Conversation.destroy_all
end


# First release everything we have
release_all

unique_generate(10, :word).each do |tag_name|
  Tag.new(name: tag_name).save!
end

# Create the known users that we want to play with
["serdarsutay@gmail.com", "rmuminoglu@gmail.com"].each do |email|
  User.new(email: email, password: "1234", password_confirmation: "1234").save!
end
admin_user = User.first

# Create some random users
unique_generate(20, :email).each do |user_email|
  User.new(email: user_email, password: '1234', password_confirmation: '1234').save!
end

organization_count = 20
# Create some random organizations
organization_count.times do
  org = Organization.new({
    name: Faker::Company.name,
    description: Faker::Lorem.paragraphs(rand(5) + 1).join("\n"),
    website: Faker::Internet.url,
    tags: Tag.all.sample(rand(5) + 2)
  })

  org.save!

  # Add an admin to the orgs
  Membership.new(user: admin_user, group: org.default_group).save!
  Membership.new(user: admin_user, group: org.admin_group).save!
end

# Randomly add some users to the organizations
User.all.each do |user|
  Organization.all.sample(rand(7) + 2).each do |org|
    Membership.new(user: user, group: org.default_group).save!
    org.groups[1..4].sample(rand(1) + 1).each do |group|
      Membership.new(user: user, group: group).save!
    end
  end
end

# Get some conversations started
100.times do
  user = User.all.sample
  group = user.groups.sample
  if user && group
    conv = Conversation.new({
      user: user,
      group: group,
      title: Faker::Lorem.sentence
    })
    conv.save!

    (rand(10) + 2).times do
      Message.new({
        user: group.users.sample,
        conversation: conv,
        body: Faker::Lorem.paragraphs(rand(5) + 1).join("\n")
      }).save!
    end
  end
end
