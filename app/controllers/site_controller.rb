class SiteController < ApplicationController
  def index
    render 'site/index'
  end

  def dashboard
    if Section.last
      if params[:section]
        @section = Section.find(params[:section])
      else
        @section = Section.first
      end
      session[:section] = @section.id
    end

    if Report.last
      if params[:report]
        @report = Report.find(params[:report])
      else
        @report = Report.last
      end
      session[:report] = @report.id
      if Report.last.nil?
        #do nothing
      else
        @sections = Section.where('report_id=?', @report.id)
        @reports = Report.all
      end
    end
  end

  def settings
    @datasets = Dataset.all()
    # if admin
    render 'site/settings'
    #else
    # render 404
  end
##
# AJAX METHODS
##

def do_action
  @dataset = Dataset.find(params[:dataset_id])
  # transform params[:column_where_equals] to Integer if it is an Integer
  if params[:column_where_equals].to_i.to_s == params[:column_where_equals]
    equal_to = params[:column_where_equals].to_i
  else
    equal_to = params[:column_where_equals]
  end
  data = @dataset.select(params[:column_name], params[:column_where], equal_to)
  if params[:operation] == 'sum'
    result = @dataset.sum(data)
  elsif params[:operation] == 'average'
    result = @dataset.average(data)
  elsif params[:operation] == 'percent'
    result = @dataset.percent(data)
  elsif params[:operation] == 'count'
    result = @dataset.count(data)
  elsif params[:operation] == 'length' # not clear what this is for
    result = @dataset.list_length(data)
  elsif params[:operation] == 'select'
    result = data
  elsif params[:operation] == 'values'
    result = @dataset.select_unique(data)
  end
  respond_to do |format|
    format.json {render json: result}
  end
end

def get_dataset_columns
  @dataset = Dataset.find(params[:dataset_id])
  respond_to do |format|
    format.json { render json: @dataset.columns }
  end
end

def get_column_actions
  require 'yaml'
  hash = YAML.load(File.read("public/config/actions.yml"))
  dataset = Dataset.find(params[:dataset_id])
  data = dataset.select(params[:column_name], params[:column_where], params[:column_where_equals])
  type = dataset.type_of(data)
   respond_to do |format|
     format.json {render json: hash[type]}
   end
end


end
