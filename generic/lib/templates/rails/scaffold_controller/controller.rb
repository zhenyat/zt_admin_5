################################################################################
#  Updates the original file:
#     railties-5.0.0.beta1.1/lib/rails/generators/rails/scaffold_controller/templates/controller.rb
#
#  28.01.2016 ZT Localization added
################################################################################
<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]

  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
  end

  def show
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
<%- for attribute in attributes -%>
  <%- if attribute.reference? -%>
    <%- if attribute.name == 'parent' -%>
    @<%= attribute.name.pluralize %> = <%= singular_table_name.camelcase %>.top_level
    <%- else -%>
    @<%= attribute.name.pluralize %> = <%= attribute.name.camelcase %>.active
    <%- end -%>
  <%- end -%>
<%- end -%>
  end

  def edit
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>, notice: <%= "t('messages.created', model: #{human_name}.class.model_name.human)" %>
    else
      render :new
    end
  end

  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to @<%= singular_table_name %>, notice: <%= "t('messages.updated', model: #{human_name}.class.model_name.human)" %>
    else
      render :edit
    end
  end

  def destroy
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_url, notice: <%= "t('messages.deleted', model: #{human_name}.class.model_name.human)" %>
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
