class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /documents or /documents.json
  def index
    @documents = Document.all
    render json: @documents
  end

  # GET /documents/1 or /documents/1.json
  def show
    @document_pages = Document.find(params[:id]).pages
    render json: {document: @document, pages: @document_pages}
  end

  # POST /documents or /documents.json
  def create
    @document = Document.new(document_params)

    if @document.save
      render json: @document, status: :created, location: @document
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    if @document.update(document_params)
      render json: @document
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    if @document.destroy
      render json: {message: "Document destroyed"}
    else
      render json: @document.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.fetch(:document, {}).permit(:title, :author, :dateCreated)
    end
end
