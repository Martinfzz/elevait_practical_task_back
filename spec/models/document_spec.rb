require 'rails_helper'

RSpec.describe Document, type: :model do

  before(:each) do 
    @document = Document.create(title: "This is a title", author: "Martin Forget", dateCreated: "2021-07-12")
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@document).to be_a(Document)
      expect(@document).to be_valid
    end

    describe "#title" do
      it "should not be valid without author and dateCreated" do
        bad_document = Document.create(title: "This is a title")
        expect(bad_document).not_to be_valid
        expect(bad_document.errors.include?(:author)).to eq(true)
        expect(bad_document.errors.include?(:dateCreated)).to eq(true)
      end

      it "should not contain more than 50 characters" do
        invalid_document = Document.create(title: "This is a very very very very very very very very very very very very long title", author: "Martin Forget", dateCreated: "2021-07-12")
        expect(invalid_document).not_to be_valid
        expect(invalid_document.errors.include?(:title)).to eq(true)
      end
    end

    describe "#author" do
      it "should not be valid without author and dateCreated" do
        bad_document = Document.create(author: "Martin Forget")
        expect(bad_document).not_to be_valid
        expect(bad_document.errors.include?(:title)).to eq(true)
        expect(bad_document.errors.include?(:dateCreated)).to eq(true)
      end

      it "should not contain more than 50 characters" do
        invalid_document = Document.create(title: "This is title", author: "Martin Forget the big boss of planet Earth, First of his name", dateCreated: "2021-07-12")
        expect(invalid_document).not_to be_valid
        expect(invalid_document.errors.include?(:author)).to eq(true)
      end
    end

    describe "#dateCreated" do
      it "should not be valid without author and dateCreated" do
        bad_document = Document.create(dateCreated: "2021-07-12")
        expect(bad_document).not_to be_valid
        expect(bad_document.errors.include?(:title)).to eq(true)
        expect(bad_document.errors.include?(:author)).to eq(true)
      end
    end

  end

  context "associations" do

    describe "document" do
      it "should have_many pages" do
        page = Page.create(text: "test", document_id: @document.id)
        expect(@document.pages.include?(page)).to eq(true)
      end
    end

  end

  context "public instance methods" do

    describe "#title" do

      it "should return a string" do
        expect(@document.title).to be_a(String)
      end

      it "should return the title" do
        @document = Document.create(title: "This is a title", author: "Martin Forget", dateCreated: "2021-07-12")
        expect(@document.title).to eq("This is a title")
        document_2 = Document.create(title: "This is another title", author: "Martin Forget", dateCreated: "2021-07-12")
        expect(document_2.title).to eq("This is another title")
      end
    end

    describe "#author" do

      it "should return a string" do
        expect(@document.author).to be_a(String)
      end

      it "should return the author" do
        @document = Document.create(title: "This is a title", author: "Martin Forget", dateCreated: "2021-07-12")
        expect(@document.author).to eq("Martin Forget")
        document_2 = Document.create(title: "This is a title", author: "Martin Forget II", dateCreated: "2021-07-12")
        expect(document_2.author).to eq("Martin Forget II")
      end
    end

    describe "#dateCreated" do

      it "should return the date" do
        @document = Document.create(title: "This is a title", author: "Martin Forget", dateCreated: "2021-07-12")
        expect(@document.dateCreated.strftime("%F")).to eq("2021-07-12")
        document_2 = Document.create(title: "This is a title", author: "Martin Forget", dateCreated: "2023-02-21")
        expect(document_2.dateCreated.strftime("%F")).to eq("2023-02-21")
      end
    end

  end
end