class Admin::StaticsController < Admin::BaseController
  def index

    @stactics = StaticPage.new
    @content= "FAQ"


    end
  
  def showfaq
    @stactics = StaticPage.new

    @content= "FAQ"

  end

  def showcontact
    @stactics = StaticPage.new

    @content= "Contact_US"

  end

  def showtc
    @stactics = StaticPage.new

    @content= "Terms Condition"

  end

  def showpp
    @stactics = StaticPage.new

    @content= "Privacy-Policy"

  end
  def create
    
    @type=params[:field]
    if @type == "faq"
      @data = StaticPage.find_by(user_id:session[:user_id]).update_column(:faq , params[:tc])
      @stactics = StaticPage.new

      @content= "FAQ"
      redirect_to request.referrer,notice: 'FAQ Successfully Added'

      # render :showfaq
      return

    end
    if @type=="tc"
      @check=StaticPage.find_by(user_id:session[:user_id])
      if(@check)
      @data = StaticPage.find_by(user_id:session[:user_id]).update_column(:tc , params[:tc])
      else
        @data= StaticPage.new(user_id:session[:user_id],tc:params[:tc])
    @data.save!
      end


      @stactics = StaticPage.new

      @content= "Terms Condition"
      # render :showtc
      redirect_to request.referrer,notice: 'Terms Condition Successfully Added'

      return
    end
    if @type=="privacy"
      
      @data = StaticPage.find_by(user_id:session[:user_id]).update_column(:privacypolicy , params[:tc])
      @stactics = StaticPage.new

      @content= "Privacy-Policy"
      # render :showpp
      redirect_to request.referrer,notice: 'Privacy-Policy Successfully Added'

      return
    end
    if @type=="contact_us"
      @data = StaticPage.find_by(user_id:session[:user_id]).update_column(:contact_us , params[:tc])
      @stactics = StaticPage.new

      @content= "contact_us"
      # render :showcontact
      redirect_to request.referrer,notice: 'Contact_Us Successfully Added'

      return
    end


    @data= StaticPage.new(user_id:session[:user_id],faq:params[:tc])
    @data.save!
    redirect_to request.referrer

  end
  
end
