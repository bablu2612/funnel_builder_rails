class FunnelsController < ApplicationController
  before_action :set_funnel, only: [:show, :edit, :update, :destroy]

  # GET /funnels
  # GET /funnels.json
  def index
    @funnels = Funnel.all

  end

  # GET /funnels/1
  # GET /funnels/1.json
  def show
  end

  def show_funnel
    begin
    @view = Page.find(params[:id]) 
    @view_p=@view.view
    @page_v="ok"
    rescue
    @page_v="not_ok"
    end

if @page_v == "not_ok"
  #@page_view = PageView.new(page_id:params[:id] ,no_of_view:"1")
 # @page_view.save!
 @data = Page.find(params[:id]).update_column(:view , @view_p+1)
else
  @data = Page.find(params[:id]).update_column(:view , @view_p+1)

    # @page_view = PageView.(page_id:params[:id] ,no_of_view:@view_p+1)
    # @page_view.save!
end
    @page = Page.find(params[:id])
    @sections = Section.where(page_id: params[:id])
  end

  # GET /funnels/new
  def new
    @funnel = Funnel.new
  end

  # GET /funnels/1/edit
  def edit
  end

  # POST /funnels
  # POST /funnels.json
  def create
    @funnel = Funnel.new(funnel_params)

    respond_to do |format|
      if @funnel.save 
        format.html { redirect_to @funnel, notice: 'Funnel has been successfully created.' }
        format.json { render :show, status: :created, location: @funnel }
      else
        format.html { render :new }
        format.json { render json: @funnel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /funnels/1
  # PATCH/PUT /funnels/1.json
  def update
    respond_to do |format|
      if @funnel.update(funnel_params)
        format.html { redirect_to @funnel, notice: 'Funnel has been successfully updated.' }
        format.json { render :show, status: :ok, location: @funnel }
      else
        format.html { render :edit }
        format.json { render json: @funnel.errors, status: :unprocessable_entity }
      end
    end
  end

  def not_found

  end

  def preview
    @preview = Preview.find_by(user_id: params[:id])
    @sections = Section.where(preview_id: @preview.id)
  end
  # DELETE /funnels/1
  # DELETE /funnels/1.json
  def destroy
    @funnel.destroy
    respond_to do |format|
      format.html { redirect_to funnels_url, notice: 'Funnel has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funnel
      @funnel = Funnel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def funnel_params
      params.require(:funnel).permit(:name)
    end
    
end
