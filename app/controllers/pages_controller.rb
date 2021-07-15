class PagesController < ApplicationController
  before_action :set_page, only: %i[ show ]
  skip_before_action :verify_authenticity_token

  # GET /pages or /pages.json
  def index
    @pages = Page.all
    render json: @pages
  end

  # GET /pages/1 or /pages/1.json
  def show
    render json: @page
  end

  # POST /pages or /pages.json
  def create
    @page = Page.new(page_params)

    if @page.save
      render json: @page, status: :created, location: @page
    else
      render json: @page.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.fetch(:page, {}).permit(:pageNr, :text, :document_id)
    end
end
