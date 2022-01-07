class Admin::ReportsController < Admin::BaseController
  def index
    Funnel.where(user_id: current_user.id).limit(1).each do |funnel|
      @pages = Page.where(funnel_id: funnel.id)
    end
  end
  def show
    PageForm.where(page_id: params[:id]).limit(1).each do |form|
    @headings = PageColumn.where(page_form_id: form.id)
    end
    @forms = PageForm.where(page_id: params[:id])

    respond_to do |format|
      format.html
      format.pdf do
          render pdf: "Report No. #{params[:id]}",
          page_size: 'A4',
          template: "admin/reports/show.html.erb",
          layout: "pdf.html",
          orientation: "Landscape",
          lowquality: true,
          zoom: 1,
          dpi: 75
      end
    end
  end
  
  
end
