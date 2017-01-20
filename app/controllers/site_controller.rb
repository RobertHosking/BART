class SiteController < ApplicationController
  def index
    render 'site/index'
  end

  def dashboard
    if params[:report]
      @report = Report.find(params[:report])
    else
      @report = Report.last
    end
    if Report.last.nil?
      #do nothing
    else
      @sections = Section.where('report_id=?', @report.id)
      @reports = Report.all
    end
  end
end
