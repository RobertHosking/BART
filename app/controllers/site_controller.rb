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

    @sections = Section.where('report_id=?', @report.id)

    @reports = Report.all
  end
end
