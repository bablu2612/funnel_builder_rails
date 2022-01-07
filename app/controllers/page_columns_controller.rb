class PageColumnsController < ApplicationController
  before_action :set_page_column, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /page_columns
  # GET /page_columns.json
  def index
    @page_columns = PageColumn.all
  end

  # GET /page_columns/1
  # GET /page_columns/1.json
  def show
  end

  # GET /page_columns/new
  def new
    @page_column = PageColumn.new
  end

  # GET /page_columns/1/edit
  def edit
  end

  # POST /page_columns
  # POST /page_columns.json
  def create
    @page_form = PageForm.new(page_id: params[:id])
    if @page_form.save
      page_column_params.each do |key,value|
        if key != "controller" && key != "action" && key != "submit" && key != "id" && key != "link"
          @page_column = PageColumn.new(page_form_id: @page_form.id,column_name: key,column_value: value)
          begin
          @page_column.save!
          rescue => e
            print(e)
          end
        end 
      end
      if @page_column.saved_changes?
        flash[:success] = "Form successfully saved."
        if params[:link]
          begin
              @page = Page.find(params[:link])
              redirect_to funnel_url_path(@page.id)
          rescue ActiveRecord::RecordNotFound
            redirect_to not_found_path
          end
        else
          redirect_to funnel_url_path(params[:id])
        end
      end
    end
  end

  # PATCH/PUT /page_columns/1
  # PATCH/PUT /page_columns/1.json
  def update
    respond_to do |format|
      if @page_column.update(page_column_params)
        format.html { redirect_to @page_column, notice: 'Page column has been successfully updated.' }
        format.json { render :show, status: :ok, location: @page_column }
      else
        format.html { render :edit }
        format.json { render json: @page_column.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_columns/1
  # DELETE /page_columns/1.json
  def destroy
    @page_column.destroy
    respond_to do |format|
      format.html { redirect_to page_columns_url, notice: 'Page column has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_column
      @page_column = PageColumn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_column_params
      params.permit!
    end
end
