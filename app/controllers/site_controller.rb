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
end
