require 'rails_helper'

RSpec.describe Page, type: :request do

  before(:each) do 
    @document = Document.create(title: "This is a title", author: "Martin Forget", dateCreated: "2021-07-12")
    @page = Page.create(pageNr: 1, text: "This is a text", document_id: @document.id)
    post '/pages', params: {page: { pageNr: 2, text: "This is another text", document_id: @document.id }}
  end

  describe "API Response" do
    it 'returns status code 200 for index#pages' do
      get '/pages'
      expect(response).to have_http_status(:success)
    end

    it 'returns status code 200 for show#pages' do
      get '/pages', params: { id: @page.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns status code 201 for create#page' do
      expect(response).to have_http_status(:created)
    end

    it 'returns the pageNr' do
      expect(JSON.parse(response.body)['pageNr']).to eq(2)
    end

    it 'returns the text' do
      expect(JSON.parse(response.body)['text']).to eq("This is another text")
    end

    it 'returns the document_id' do
      expect(JSON.parse(response.body)['document_id']).to eq(1)
    end
  end
end