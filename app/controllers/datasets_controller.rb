class DatasetsController < ApplicationController
  before_action :set_dataset, only: [:show, :edit, :update, :destroy]

  # GET /datasets
  # GET /datasets.json
  def index
    @datasets = Dataset.all
  end

  # GET /datasets/1
  # GET /datasets/1.json
  def show
    require 'roo'

    @dataset = Dataset.find_by(id: params[:id])
    @xlsx = Roo::Spreadsheet.open(@dataset[:original_file])
    @data = Entry.find_by(dataset_id: @dataset.id)
  end

  # GET /datasets/new
  def new
    @dataset = Dataset.new
  end

  # GET /datasets/1/edit
  def edit
  end

  # POST /datasets
  # POST /datasets.json
  def create
      require 'roo'
      require 'fileutils'


      @dataset = Dataset.new(dataset_params)
      uploaded_io = params[:dataset][:csv]
      # Path to original uploaded file
      @dataset.base_path = Rails.root.join('public', 'datasets', @dataset[:year], @dataset[:term])
      @dataset.original_file = Rails.root.join('public', 'datasets',@dataset[:year],@dataset[:term], uploaded_io.original_filename)
      # Path to spreadsheet with active and current data /public/datasets/[year]/[term]/[ACTIVE COPY]myspreadsheet.xlsx
      @dataset.working_file = Rails.root.join('public', 'datasets', @dataset[:year], @dataset[:term], "[Active Copy]"+uploaded_io.original_filename)
      # Path to yaml file (used for displaying spreadsheet data) /public/datasets/[year]/[term]/[created_at].yml
      #@dataset.yaml_file = Rails.root.join('public', 'datasets', @dataset[:year], @dataset[:term], Time.now.to_i.to_s + ".yml")

      # Save the original and create the working copy
      # Create the directory if it does not exist
      FileUtils::mkdir_p(@dataset.base_path) unless File.directory?(@dataset.base_path)
        File.open(@dataset.original_file, 'wb') do |file|
            file.write(uploaded_io.read)
        end
        #Create a Working Copy
        FileUtils::cp(@dataset.original_file, @dataset.working_file)
        # Create the YAML

        Dataset.sheet_to_db(Roo::Spreadsheet.open(@dataset[:original_file]))

    respond_to do |format|
      if @dataset.save
        format.html { redirect_to @dataset, notice: 'Dataset was successfully created.' }
        format.json { render :show, status: :created, location: @dataset }
      else
        format.html { render :new }
        format.json { render json: @dataset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datasets/1
  # PATCH/PUT /datasets/1.json
  def update
    respond_to do |format|
      if @dataset.update(dataset_params)
        format.html { redirect_to @dataset, notice: 'Dataset was successfully updated.' }
        format.json { render :show, status: :ok, location: @dataset }
      else
        format.html { render :edit }
        format.json { render json: @dataset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datasets/1
  # DELETE /datasets/1.json
  def destroy
    @dataset.destroy
    respond_to do |format|
      format.html { redirect_to datasets_url, notice: 'Dataset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dataset
      @dataset = Dataset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dataset_params
      params.fetch(:dataset, {})
    end

    private
    def dataset_params
        params.require(:dataset).permit(:csv, :name, :term, :year,:original,:yaml,:working)
    end

   end
