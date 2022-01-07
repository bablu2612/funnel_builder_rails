class Api::V1::FunnelsController < Api::V1::BaseController
    before_action :auth_request
     before_action :check_user
    before_action :set_funnel, only: [:show, :destroy]
    
    def preview
        begin
            Preview.where(user_id: @@current_user.id).each do |preview|
                preview.destroy!
            end
        rescue => e
            render json: {type: "error",status: 500, message: "#{e}"}
        end
        @preview = Preview.new(user_id: @@current_user.id,background: page_params[:background])
        @preview.save!
        preview_id = @preview.id
       
        element_params[:sections].each do |element|
            @page_section = Section.new(preview_id: preview_id)
            if @page_section.save!
                if element[:styles].present?
                    element[:styles].each do |key,value|
                        @style = Style.new(section_id: @page_section.id,style: key,value: value)
                        @style.save!
                    end
                end
                if element[:attributes].present?
                    element[:attributes].each do |key,value|
                        @style = SecAttribute.new(section_id: @page_section.id,attri: key,value: value)
                        @style.save!
                    end
                end
                element[:containers].each do |container|
                    @page_container = Container.new(section_id: @page_section.id)
                    if @page_container.save!
                        if container[:styles].present?
                            container[:styles].each do |key,value|
                                @style = Style.new(container_id: @page_container.id,style: key,value: value)
                                @style.save!
                            end
                        end
                        if container[:attributes].present?
                            container[:attributes].each do |key,value|
                                @style = SecAttribute.new(container_id: @page_container.id,attri: key,value: value)
                                @style.save!
                            end
                        end
                        container[:rows].each do |row|
                            @page_row = Row.new(container_id: @page_container.id)
                            if @page_row.save!
                                if row[:styles].present?
                                    row[:styles].each do |key,value|
                                        @style = Style.new(row_id: @page_row.id,style: key,value: value)
                                        @style.save!
                                    end
                                end
                                if row[:attributes].present?
                                    row[:attributes].each do |key,value|
                                        @style = SecAttribute.new(row_id: @page_row.id,attri: key,value: value)
                                        @style.save!
                                    end
                                end
                                row[:columns].each do |column|
                                    @page_col = Column.new(row_id: @page_row.id)
                                    if @page_col.save!
                                        if column[:styles].present?
                                            column[:styles].each do |key,value|
                                                @style = Style.new(column_id: @page_col.id,style: key,value: value)
                                                @style.save!
                                            end
                                        end
                                        if column[:attributes].present?
                                            column[:attributes].each do |key,value|
                                                @style = SecAttribute.new(column_id: @page_col.id,attri: key,value: value)
                                                @style.save!
                                            end
                                        end
                                        column[:fields].each do |field|
                                            @p_element = PageElement.new(column_id: @page_col.id,field: field["field"],value: field["value"])
                                            @p_element.save!
                                            if field[:attributes].present?
                                                field[:attributes].each do |key,value|
                                                    @attr = ElementAttribute.new(page_element_id: @p_element.id,attribute_name: key,attribute_value: value)
                                                    @attr.save!
                                                end
                                            end
                                            if field[:styles].present?
                                                field[:styles].each do |key,value|
                                                    @style = ElementStyle.new(page_element_id: @p_element.id,style: key,value: value)
                                                    @style.save!
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        render json: {type: "success",status: 200,data: {preview_url: "#{request.base_url}/preview/#{@@current_user.id}"}, message: 'Funnel has been created.'}
    end

    def show_funnel
        
        @funnels = Funnel.where(user_id: @@current_user.id)
        @data = @funnels.map do |funnel|
        @pages = Page.where(funnel_id: funnel.id)
            {
            :id => funnel.id,
            :name => funnel.name,
            :pages => @pages.map do |page|
                {
                    :id => page.id,
                    :funnel_id => funnel.id,
                    :name => page.name,
                    :preview => page.screenshot
                }end
            }end
            render json: {type: "success",status: 200,data: @data,message: "All funnels of user"}  
    end

    
    def show
        @pages = Page.where(funnel_id: @funnel.id)
        @data = {
            :funnel_id => @funnel.id,
            :funnel_name => @funnel.name,
            :pages => @pages.map do  |page|
            @sections = Section.where(page_id: page.id)
            {:page_id => page.id,
             :preview => page.screenshot,
             :page_name => page.name,
             :sections => @sections.map do |section|
            @containers = Container.where(section_id: section.id)
            @attributes1 = SecAttribute.where(section_id: section.id)
            @styles1 = Style.where(section_id: section.id)  
            {:containers => @containers.map do |cont|
                @rows = Row.where(container_id: cont.id)
                @attributes2 = SecAttribute.where(container_id: cont.id)
                @styles2 = Style.where(container_id: cont.id)    
                {:rows => 
                    @rows.map do |row|
                        @columns = Column.where(row_id: row.id)
                        @attributes3 = SecAttribute.where(row_id: row.id)
                        @styles3 = Style.where(row_id: row.id)    
                        {:columns => 
                            @columns.map do |col|
                                @elements = PageElement.where(column_id: col.id)
                                @attributes4 = SecAttribute.where(column_id: col.id)
                                @styles4 = Style.where(column_id: col.id)   
                                { :fields => 
                                    @elements.map do |element|
                                        @attributes5 = ElementAttribute.where(page_element_id: element.id)
                                        @styles5 = ElementStyle.where(page_element_id: element.id)
                                        {:field => element.field,
                                        :value => element.value,
                                        :attributes => @attributes5.map {  |atttri| {atttri.attribute_name => atttri.attribute_value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)},
                                        :styles => @styles5.map {  |style| {style.style => style.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)}
                                    }end,
                                :attributes => @attributes4.map {  |atttri| {atttri.attri => atttri.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)},
                                :styles => @styles4.map {  |style| {style.style => style.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)},
                        }end,
                    :attributes => @attributes3.map {  |atttri| {atttri.attri => atttri.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)},
                    :styles => @styles3.map {  |style| {style.style => style.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)}
                }end,
                :attributes => @attributes2.map {  |atttri| {atttri.attri => atttri.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)},
                :styles => @styles2.map {  |style| {style.style => style.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)}
            }end,
            :attributes => @attributes1.map {  |atttri| {atttri.attri => atttri.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)},
            :styles => @styles1.map {  |style| {style.style => style.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)}
        }end}end}
            
        
        render json: {type: "success",status: 200,data: @data,message: "Data of funnel id #{@funnel.id}"}
    end

      #post Create funnel with no page
      def create_funnel
        @funnel = Funnel.new(user_id: @@current_user.id,name: page_params[:funnel_name])
            @funnel.save!
            @funnel_id = @funnel.id
            render json: {type: "success",status: 200,id:@funnel.id, message: "New funnel created without blank page"}
    end            

#1may20 create by bablu for block user checks
def check_user

    @data_a = User.find(@user.id)

if(@data_a.block_status == "block")
        
    render json: { type: "error",status: 400, message: 'User is block by admin.', user_id: @user.id }

    return;
   
end
   

end
    #2.1.1 27Feb20 Bablu >> Updated funtion For added two new parmeter title, description in table pages for google search = part2
    def create
        if !page_params[:funnel_id].present?
            @funnel = Funnel.new(user_id: @@current_user.id,name: page_params[:funnel_name])
            @funnel.save!
            @funnel_id = @funnel.id
            funnel_exists = true
        else
            if  Funnel.exists?(id: page_params[:funnel_id])
                @funnel_id = page_params[:funnel_id]
            else
                funnel_exists = false      
            end
        end

        if !page_params[:page_id].present?
            @page = Page.new(funnel_id: @funnel_id,name: page_params[:page_name],background: page_params[:background],description: page_params[:description],title: page_params[:title])
            @page.save!
            page_id = @page.id
            page_exists = true
        else
            if funnel_exists != false
                if Page.exists?(id: page_params[:page_id])
                    if Page.exists?(funnel_id: page_params[:funnel_id],id: page_params[:page_id])
                        page_id = page_params[:page_id]
                        @sections = Section.where(page_id: page_id)
                        if @sections != nil
                            @sections.each do |section|
                                section.destroy
                            end
                        end
                        relation_exists = true
                    else
                        relation_exists = false
                    end
                else 
                    page_exists = false
                end
            else
                funnel_exists = false 
            end
        end
        

        if funnel_exists != false
            if page_exists != false
                if relation_exists != false
                    element_params[:sections].each do |element|
                        @page_section = Section.new(page_id: page_id)
                        if @page_section.save!
                            if element[:styles].present?
                                element[:styles].each do |key,value|
                                    @style = Style.new(section_id: @page_section.id,style: key,value: value)
                                    @style.save!
                                end
                            end
                            if element[:attributes].present?
                                element[:attributes].each do |key,value|
                                    @style = SecAttribute.new(section_id: @page_section.id,attri: key,value: value)
                                    @style.save!
                                end
                            end
                            element[:containers].each do |container|
                                @page_container = Container.new(section_id: @page_section.id)
                                if @page_container.save!
                                    if container[:styles].present?
                                        container[:styles].each do |key,value|
                                            @style = Style.new(container_id: @page_container.id,style: key,value: value)
                                            @style.save!
                                        end
                                    end
                                    if container[:attributes].present?
                                        container[:attributes].each do |key,value|
                                            @style = SecAttribute.new(container_id: @page_container.id,attri: key,value: value)
                                            @style.save!
                                        end
                                    end
                                    container[:rows].each do |row|
                                        @page_row = Row.new(container_id: @page_container.id)
                                        if @page_row.save!
                                            if row[:styles].present?
                                                row[:styles].each do |key,value|
                                                    @style = Style.new(row_id: @page_row.id,style: key,value: value)
                                                    @style.save!
                                                end
                                            end
                                            if row[:attributes].present?
                                                row[:attributes].each do |key,value|
                                                    @style = SecAttribute.new(row_id: @page_row.id,attri: key,value: value)
                                                    @style.save!
                                                end
                                            end
                                            row[:columns].each do |column|
                                                @page_col = Column.new(row_id: @page_row.id)
                                                if @page_col.save!
                                                    if column[:styles].present?
                                                        column[:styles].each do |key,value|
                                                            @style = Style.new(column_id: @page_col.id,style: key,value: value)
                                                            @style.save!
                                                        end
                                                    end
                                                    if column[:attributes].present?
                                                        column[:attributes].each do |key,value|
                                                            @style = SecAttribute.new(column_id: @page_col.id,attri: key,value: value)
                                                            @style.save!
                                                        end
                                                    end
                                                  
                                                    column[:fields].each do |field|
                                                       
                                                        if field["field"]=="popup" #updated by bablu :purpose=>add popup in page12mar20
                                                           
                                                            @id = Page.select('id').where(funnel_id: @funnel_id)
                                                            @input=field["value"]
                                                            if @input.include? "~~~"
                                                               @input= @input.split("~~~")
                                                               begin
                                                                @pagefind= @id.find(@input[0])
                                                                @popup="true"
                                                              rescue
                                                                @popup="false"
                                                              end   
                                                            else
                                                                begin
                                                                    @pagefind= @id.find(@input)
                                                                    @popup="true"
                                                                  rescue
                                                                    @popup="false"
                                                                  end   
                                                            end
                                                            # begin
                                                            #     @pagefind= @id.find(@input[0])
                                                            #     @popup="true"
                                                            #   rescue
                                                            #     @popup="false"
                                                            #   end   
                                                            
                                                        #    @pagefind= @id.find(field["value"])
                                                           if @popup == "true"
                                                            @p_element = PageElement.new(column_id: @page_col.id,field: field["field"],value: field["value"])
                                                            @p_element.save!
                                                           else
                                                            @popup="false"
                                                           end
                                                        else
                                                            @p_element = PageElement.new(column_id: @page_col.id,field: field["field"],value: field["value"])
                                                            @p_element.save!
                                                        end
                                                        if @popup != "false"
                                                        if field[:attributes].present?
                                                            field[:attributes].each do |key,value|
                                                                @attr = ElementAttribute.new(page_element_id: @p_element.id,attribute_name: key,attribute_value: value)
                                                                @attr.save!
                                                            end
                                                        end
                                                        if field[:styles].present?
                                                            field[:styles].each do |key,value|
                                                                @style = ElementStyle.new(page_element_id: @p_element.id,style: key,value: value)
                                                                @style.save!
                                                            end
                                                        end
                                                    end
                                               end
                                            end 
                                        end
                                    end
                                  end
                              end
                           end
                      end
                   end
                    begin
                        page = Page.find(page_id)
                        response = HTTParty.get("#{request.base_url}/funnel_url/#{page.id}")
                        kit = IMGKit.new(response.body, :quality => 50)
                        kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/bootstrap.min.css"
                        file_path = "#{Rails.root}/app/assets/images/screenshots/screenshot#{page.id}.jpg"
                        kit.to_file("#{(file_path).to_s}")
                        page.update(screenshot: "#{request.base_url}/assets/screenshots/screenshot#{page.id}.jpg")
                        if @popup =="false"
                        render json: {type: "success",status: 200,data: {funnel_id: @funnel_id,Popup_status: 'popup is not added',page_id: page_id,url: "#{request.base_url}/funnel_url/#{page_id}",preview: "#{request.base_url}/assets/screenshots/screenshot#{page.id}.jpg"}, message: 'Funnel is created.'}
                        else
                       render json: {type: "success",status: 200,data: {funnel_id: @funnel_id,page_id: page_id,url: "#{request.base_url}/funnel_url/#{page_id}",preview: "#{request.base_url}/assets/screenshots/screenshot#{page.id}.jpg"}, message: 'Funnel is created.'}
                        end
                    rescue
                        if @popup =="false"
                        render json: {type: "success",status: 200,data: {funnel_id: @funnel_id,page_id: page_id, Popup_status: 'popup is not added' , url: "#{request.base_url}/funnel_url/#{page_id}",preview: "http://dev7.csdevhub.com/assets/screenshots/screenshot20.jpg"}, message: 'Funnel is created.'}
                        else
                      render json: {type: "success",status: 200,data: {funnel_id: @funnel_id,page_id: page_id, url: "#{request.base_url}/funnel_url/#{page_id}",preview: "http://dev7.csdevhub.com/assets/screenshots/screenshot20.jpg"}, message: 'Funnel is created.'}
                        end
                    end
                else
                    render json: {type: "error",status: 400, message: "Funnel and Page relation not exist in funnel id #{page_params[:funnel_id]} and page id #{page_params[:page_id]}"}
                end
            else
                render json: {type: "error",status: 400, message: "Page is not exist with page id #{page_params[:page_id]}"}
            end
        else
            render json: {type: "error",status: 400, message: "Funnel is not exist with funnel id #{page_params[:funnel_id]}"}
        end
    end
    
    
    def show_records
        begin
            @page = Page.find(params[:id])
            @sections = Section.where(page_id: params[:id])
        
            @data = {
                :page_id => @page.id,
                :page_name => @page.name,
                :funnel_id => @page.funnel.id,
                :funnel_name => @page.funnel.name,
                :preview => @page.screenshot,
                :sections => @sections.map do |section|
                @containers = Container.where(section_id: section.id)
                @attributes1 = SecAttribute.where(section_id: section.id)
                @styles1 = Style.where(section_id: section.id)  
                {:containers => @containers.map do |cont|
                    @rows = Row.where(container_id: cont.id)
                    @attributes2 = SecAttribute.where(container_id: cont.id)
                    @styles2 = Style.where(container_id: cont.id)    
                    {:rows => 
                        @rows.map do |row|
                            @columns = Column.where(row_id: row.id)
                            @attributes3 = SecAttribute.where(row_id: row.id)
                            @styles3 = Style.where(row_id: row.id)    
                            {:columns => 
                                @columns.map do |col|
                                    @elements = PageElement.where(column_id: col.id)
                                    @attributes4 = SecAttribute.where(column_id: col.id)
                                    @styles4 = Style.where(column_id: col.id)   
                                    { :fields => 
                                        @elements.map do |element|
                                            @attributes5 = ElementAttribute.where(page_element_id: element.id)
                                            @styles5 = ElementStyle.where(page_element_id: element.id)
                                            {:field => element.field,
                                            :value => element.value,
                                            :attributes => @attributes5.map {  |atttri| {atttri.attribute_name => atttri.attribute_value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)},
                                            :styles => @styles5.map {  |style| {style.style => style.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)}
                                        }end,
                                    :attributes => @attributes4.map {  |atttri| {atttri.attri => atttri.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)},
                                    :styles => @styles4.map {  |style| {style.style => style.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)},
                            }end,
                        :attributes => @attributes3.map {  |atttri| {atttri.attri => atttri.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)},
                        :styles => @styles3.map {  |style| {style.style => style.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)}
                    }end,
                    :attributes => @attributes2.map {  |atttri| {atttri.attri => atttri.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)},
                    :styles => @styles2.map {  |style| {style.style => style.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)}
                }end,
                :attributes => @attributes1.map {  |atttri| {atttri.attri => atttri.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)},
                :styles => @styles1.map {  |style| {style.style => style.value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)}
            }end}
                
            
            render json: {type: "success",status: 200,data: @data,message: "Data of funnel id #{@page.funnel.id}"} 
        rescue ActiveRecord::RecordNotFound
            render json: {type: "error", message: "Page not found with id #{params[:id]}" ,status: 404,}
        end
    
    end

    def destroy
        if @funnel.destroy
            render json: { type: 'success',status: 200, message: 'Funnel has been deleted.' }
        end
    end

    # Method to update a specific funnel aganist funnel id. User will need to be authorized.
    def rename
        @funnelDetails = Funnel.find(params[:id])
        
        if @funnelDetails.update(name: page_data_params[:funnel_name])
            render json: {type: "success",status: 200, message:'Funnel renamed successfully' }
        elsif @funnelDetails.errors.any?
            render json: {type: "error",status: 400, message: @funnelDetails.errors.messages}
        else
            render json: {type: "error",status: 400, message: 'error.'}
        end
    end

    private
    def set_funnel
        begin
            @funnel = Funnel.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            render json: {type: "error", message: "Funnel not found with id #{params[:id]}" ,status: 404,}
        end
    end
    # Setting up strict parameters for when we add account creation.
    def funnel_params#parmit for array params
        params.permit(:data,:section,:container,:row,:column)
    end
    
    def element_params#parmit for inner data of array params
        params.permit(data: [sections: [containers: [ rows: [columns: [fields: [:field,:value,:attributes => {},:styles => {}],:attributes => {},:styles => {}],:attributes => {},:styles => {}],:attributes => {},:styles => {}],:attributes => {},:styles => {}]]).require(:data)
    end 

    #2.1.2 27Feb20 Bablu >> Updated funtion For added two new parmeter title, description in table pages for google search = part1
    def page_params#parmit for data params
        params.require(:data).permit(:funnel_name,:page_id,:funnel_id,:page_name,:background,:description,:title)
    end  
    
    def page_data_params#parmit for data params
        params.permit(:funnel_name)
    end 

end
