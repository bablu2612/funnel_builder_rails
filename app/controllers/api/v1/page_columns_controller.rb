class Api::V1::PageColumnsController < Api::V1::BaseController
    before_action :auth_request

    def show_all
        @page_form = PageForm.where(page_id: params[:id])
        @data = @page_form.map do |form|
        @columns = PageColumn.where(page_form_id: form.id)
            {
            :from_id => form.id,
            :columns => @columns.map {|column|{column.column_name => column.column_value}}.each_with_object({}) { |oh, nh| nh.merge!(oh)}
            }end
        render json: {type: "success", data: @data,message: "all forms columns data of page id #{params[:id]}"}
    end
end
