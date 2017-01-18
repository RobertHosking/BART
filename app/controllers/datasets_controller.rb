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
      @dataset.active = true
      uploaded_io = params[:dataset][:csv]
      # Path to original uploaded file
      @dataset.base_path = Rails.root.join('public', 'datasets', @dataset[:year], @dataset[:term], @dataset.name)
      @dataset.original_file = Rails.root.join(@dataset.base_path, uploaded_io.original_filename)
      # Path to spreadsheet with active and current data /public/datasets/[year]/[term]/[ACTIVE COPY]myspreadsheet.xlsx
      @dataset.working_file = Rails.root.join(@dataset.base_path, "[Active Copy]"+uploaded_io.original_filename)
      # Path to yaml file (used for displaying spreadsheet data) /public/datasets/[year]/[term]/[created_at].yml
      @dataset.yaml_file = Rails.root.join(@dataset.base_path, "versions" ,Time.now.to_i.to_s + ".yml")
      # Save the original and create the working copy
      # Create the directory if it does not exist
      Dataset.write_to(@dataset.original_file, uploaded_io.read)
      yaml = Dataset.sheet_to_yaml(Roo::Spreadsheet.open(@dataset[:original_file]))
      Dataset.write_to(@dataset.yaml_file, yaml)
      #Create a Working Copy
      FileUtils::cp(@dataset.original_file, @dataset.working_file)
      #@dataset.yaml_to_sheet(@dataset.yaml_file).to_csv(Rails.root.join(@dataset.base_path, "build.csv"))
      # Create the YAML
      @dataset.columns = @dataset.get_columns


    respond_to do |format|
      if @dataset.save
        format.html { redirect_to '/dashboard', notice: 'Dataset was successfully created.' }
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
    require 'roo'
    respond_to do |format|
      if @dataset.update(dataset_params)
        @dataset.write_columns_to_sheet
        Dataset.write_to(@dataset.yaml_file, Dataset.sheet_to_yaml(Roo::Spreadsheet.open(@dataset.working_file)))
        format.html { redirect_to '/dashboard', notice: 'Dataset was successfully updated.' }
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
    require 'fileutils'

    # TODO delete or relocate all files of dataset
    FileUtils.rm_rf(@dataset.base_path)
    @dataset.destroy
    respond_to do |format|
      format.html { redirect_to '/dashboard', notice: 'Dataset was successfully destroyed.' }
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
        params.require(:dataset).permit(:csv, :name, :term, :year,:original,:yaml,:working, :columns => [])
    end

   end
