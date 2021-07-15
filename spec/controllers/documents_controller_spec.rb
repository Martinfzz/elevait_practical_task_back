require 'rails_helper'

RSpec.describe Document, type: :request do

  before(:each) do 
    @document = Document.create(title: "This is a title", author: "Martin Forget", dateCreated: "2021-07-12")
    post '/documents', params: {document: { title: "This is another title", author: "Martin Forget II", dateCreated: "2021-07-13" }}
  end

  describe "API Response" do
    it 'returns status code 200 for index#documents' do
      get '/documents'
      expect(response).to have_http_status(:success)
    end

    it 'returns status code 200 for show#documents' do
      get '/documents', params: { id: @document.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns status code 201 for create#documents' do
      expect(response).to have_http_status(:created)
    end

    it 'returns the title' do
      expect(JSON.parse(response.body)['title']).to eq('This is another title')
    end

    it 'returns the author' do
      expect(JSON.parse(response.body)['author']).to eq('Martin Forget II')
    end

    it 'returns the date' do
      expect(JSON.parse(response.body)['dateCreated']).to eq('2021-07-13T00:00:00.000Z')
    end
  end
end