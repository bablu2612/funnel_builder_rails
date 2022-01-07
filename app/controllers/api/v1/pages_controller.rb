class Api::V1::PagesController < Api::V1::BaseController
    before_action :auth_request
    before_action :set_page, only: [:destroy]
    
    def destroy
        if @page.destroy
            render json: { type: 'success',status: 200, message: 'Page has been deleted.' }
        end
    end
 
    #  Method to update a specific page aganist page id. User will need to be authorized.
    def rename 
        @pageDetails = Page.find(params[:id])
                                                                                               
        if @pageDetails.update(name: page_data_params[:page_name])
            render json: {type: "success",status: 200, message:'Page renamed successfully' }
        elsif @pageDetails.errors.any?
            render json: {type: "error",status: 400, message: @pageDetails.errors.messages}
        else 
            render json: {type: "error",status: 400, message: 'error.'}
        end
    end
 
  
    def show_static_page
        
        @Static_page = StaticPage.find_by(user_id: @@current_user.id)
        
    if(@Static_page)

        @content=@Static_page[params[:page_name]]
        render json: {type: "sucess", message: "Page found ",data: "#{@content}" ,status: 200,}
    else
        render json: {type: "error", message: " Page not found with id #{@@current_user.id}" ,status: 404,}

    end

       

        

    end
  
    
    #1.1.1 18Feb20 Creted By Pradeep Prajapati  Purpose: page data against page_id same as on admin panel did by Gurbhej Ji
    # 03Mar20 Updated By Bablu             Purpose: update Format of output  
    def get_data_page_wise
        @page_form = PageForm.where(page_id: params[:id])
        @data = @page_form.map do |form|
        @columns = PageColumn.where(page_form_id: form.id)
            # {
            # # :from_id => form.id,
            # # :submit_date => form.created_at.strftime("%F %T"),
            # # :column=> @columns.map {|column|{column.column_name => column.column_value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)}

            # }
            @form_data = @columns.map {|column|{:form_id =>column.page_form_id,:created_at => column.created_at.strftime("%F %T"),column.column_name => column.column_value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)}
        end
        render json: {type: "success", data: @data, message: "All forms columns data of page id #{params[:id]}"}
    end 


#get code data page wise
#1.1.2 25feb20 created By Bablu             Purpose: display page code data to frontend.  
def get_page_codedata
    @page_form = PageCode.where(page_id: params[:id])
    @data = @page_form.map do |form|
        {
        :id => form.id,
        :type => form.code_type,
        :code => form.code,
        }
    end
    render json: {type: "success", data: @data,message: "All code data of page id #{params[:id]}"}

end 

#1.1.3 25feb20 created By Bablu             Purpose: store code data from page into db.  
def add_code
        @page = PageCode.new(page_id:page_code_params[:page_id] ,code_type: page_code_params[:code_type],code: page_code_params[:code])
        @page.save!
       
            if @page.save 
                render json: {type: "success", data: @page,message: "code are saved with id #{page_code_params[:page_id]} "}
            else
                render json: {type: "error", message: "Page not found with id #{page_code_params[:page_id]}" ,status: 404,}

            
          end
    end

    private

    def set_page
        begin
            @page = Page.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: {type: "error", message: "Page not found with id #{params[:id]}" ,status: 404,}
        end
    end
    
    def page_params#parmit for data params
        params.require(:data).permit(:page_id,:page_name,:funnel_id)
    end

    # 1.0 Creaded Just for Rename method only to get data without array 
    def page_data_params#parmit for data params
        params.permit(:page_name)
    end  

   
    
    
#1.1.4 Created By Bablu   Purpose: parmit for page code data params
    def page_code_params
        params.require(:data).permit(:page_id,:code,:code_type)
    end

end
