require 'rails_helper'

RSpec.describe Page, type: :model do

  before(:each) do 
    @document = Document.create(title: "This is a title", author: "Martin Forget", dateCreated: "2021-07-12")
    @page = Page.create(pageNr: 1, text: "This is a text", document_id: @document.id)
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@page).to be_a(Page)
      expect(@page).to be_valid
    end

    describe "#pageNr" do
      it "should not be valid without text and document_id" do
        bad_page = Page.create(pageNr: 1)
        expect(bad_page).not_to be_valid
        expect(bad_page.errors.include?(:text)).to eq(true)
        expect(bad_page.errors.include?(:document_id)).to eq(true)
      end
    end

    describe "#text" do
      it "should not be valid without pageNr and document_id" do
        bad_page = Page.create(text: "This is a text")
        expect(bad_page).not_to be_valid
        expect(bad_page.errors.include?(:pageNr)).to eq(true)
        expect(bad_page.errors.include?(:document_id)).to eq(true)
      end

      it "should not contain more than 280 characters" do
        invalid_page = Page.create(pageNr: 1, text: "This is very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very long a text", document_id: @document.id)
        expect(invalid_page).not_to be_valid
        expect(invalid_page.errors.include?(:text)).to eq(true)
      end
    end

    describe "#document_id" do
      it "should not be valid without pageNr and text" do
        bad_page = Page.create(document_id: @document.id)
        expect(bad_page).not_to be_valid
        expect(bad_page.errors.include?(:pageNr)).to eq(true)
        expect(bad_page.errors.include?(:text)).to eq(true)
      end
    end

  end

  context "associations" do

    describe "page" do
      it "should belongs_to document" do
        expect(@page.document.id).to eq(@document.id)
      end
    end

  end

  context "public instance methods" do

    describe "#pageNr" do

      it "should return an integer" do
        expect(@page.pageNr).to be_a(Integer)
      end

      it "should return the pageNr" do
        expect(@page.pageNr).to eq(1)
        page_2 = Page.create(pageNr: 12, text: "This is a text", document_id: @document.id)
        expect(page_2.pageNr).to eq(12)
      end
    end

    describe "#text" do

      it "should return a string" do
        expect(@page.text).to be_a(String)
      end

      it "should return the author" do
        expect(@page.text).to eq("This is a text")
        page_2 = Page.create(pageNr: 12, text: "This is another text", document_id: @document.id)
        expect(page_2.text).to eq("This is another text")
      end
    end

    describe "#document_id" do

    it "should return an integer" do
      expect(@page.document_id).to be_a(Integer)
    end

      it "should return the document_id" do
        expect(@page.document_id).to eq(1)
        document_2 = Document.create(title: "This is another title", author: "Martin Forget", dateCreated: "2021-07-12")
        page_2 = Page.create(pageNr: 12, text: "This is another text", document_id: document_2.id)
        expect(page_2.document_id).to eq(2)
      end
    end

  end
end