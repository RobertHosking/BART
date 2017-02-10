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

##
# AJAX METHODS
##

def columns
  @dataset = Dataset.find(params[:dataset_id])
  respond_to do |format|
    format.json { render json: @dataset.columns }
  end
end

def actions
  @dataset = Dataset.find(params[:dataset_id])
  type = @dataset.type_of(params[:column_name])
  if type == "Number"
    #send templates
    respond_to do |format|
      format.json { render json: type}
    end
  elsif type == "String"
    #send templst
    respond_to do |format|
      format.json { render json: type }
    end
  elsif type == "Time"
    #sed templates
    respond_to do |format|
      format.json { render json: type }
    end
  end
end


end
