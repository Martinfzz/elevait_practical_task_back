require 'faker'

Document.destroy_all
Page.destroy_all

# DOCUMENTS
5.times do
  document = Document.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    author: Faker::Name.name,
    dateCreated: Faker::Date.between(from: 2.days.ago, to: Date.today),
  )
  puts "Create Documents"
end

# PAGES
i = Document.first.id
5.times do
  page = Page.create!(
    pageNr: 1,
    text: Faker::Lorem.sentence(word_count: 10),
    document: Document.find(i),
    )
  i+=1
  puts "Create Pages"
end

