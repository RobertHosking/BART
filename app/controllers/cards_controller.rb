class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token
  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.all
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
    @sections = Section.all
    @datasets = Dataset.all

    @column_select_options = []
  end
  # GET /cards/1/edit
  def edit
  end

  include Editor

  def preview
    @preview = Editor.text_parse(params[:html])
    render "cards/preview", :layout => false

  end
  # POST /cards
  # POST /cards.json
  def create
    puts params
    @card = Card.new()
    @card.section_id = params[:card][:section_id]
    @card.level = params[:card][:level]
    @card.where_equals=params[:card][:where_equals]
    @card.title=params[:card][:title]
    @card.column=params[:card][:column]
    @card.chart_type=params[:card][:chart_type]
    @card.dataset_id=params[:card][:dataset_id]
    @card.where_column=params[:card][:where_column]
    @card.action=params[:card][:action]


    respond_to do |format|
      if @card.save
        format.html { redirect_to '/dashboard', notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to '/dashboard', notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to '/dashboard', notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit()
      #params.fetch(:card, {})
    end
end
