class Admin::FunnelsController < Admin::BaseController
  before_action :set_funnel, only: [:show, :edit, :update, :destroy]

  # GET /funnels
  # GET /funnels.json
  def index
    
    @text = params[:id]
  if @text==nil
    @funnels = Funnel.all
  else
    @funnels = Funnel.where(user_id:params[:id])
  end

  end

  # GET /funnels/1
  # GET /funnels/1.json
  def show
    @funnels = Funnel.where(user_id:params[:id])
  end

  def show_funnel
   
    @pages = PageElement.where(page_id: params[:id])
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
  def rename
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
