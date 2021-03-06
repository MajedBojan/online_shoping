class V1::BaseController < V1::ApiController
  before_action :set_resource, only: %i[show update destroy]

  ## ------------------------------------------------------------ ##

  # GET : /v1/{resource}
  def index
    data = { resource_node.pluralize.to_sym => get_collection.as_api_response(index_template, template_injector) }
    render_data(data,
                meta: pagination(get_collection),
                message: index_message(get_collection))
  end


  ## ------------------------------------------------------------ ##

  # GET : /v1/{resource}/:id
  def show
    return render_not_found if get_resource.nil?
    render_data(resource_node.singularize.to_sym => get_resource.as_api_response(show_template, template_injector))
  end

  ## ------------------------------------------------------------ ##

  # POST : /v1/{resource}/:id
  def create
    set_resource(resource_class.new(params_processed))
    if get_resource.save
      message = action_message[:create] || I18n.t(:x_created_successfully, name: resource_name.titleize)
      render_created({ resource_node.singularize.to_sym => get_resource.as_api_response(show_template, template_injector) }, message: message)
    else
      render_unprocessable_entity(error: get_resource)
    end
  end

  ## ------------------------------------------------------------ ##

  # PUT : /v1/{resource}/:id
  def update
    if get_resource.update(params_processed)
      message = action_message[:update] || I18n.t(:x_update_successfully, name: resource_name.titleize)
      render_data({ resource_node.singularize.to_sym => get_resource.as_api_response(show_template, template_injector) }, message: message)
    else
      render_unprocessable_entity(error: get_resource)
    end
  end

  ## ------------------------------------------------------------ ##

  # DELETE : /v1/{resource}/:id
  def destroy
    if get_resource.destroy
      render_success(action_message[:destroy] || I18n.t(:x_deleted_successfully, name: resource_name.titleize))
    else
      render_unprocessable_entity(error: get_resource)
    end
  end
  ## ------------------------------------------------------------ ##

  private

  # Get the returned object from Power
  # @return [Object]
  def get_scope
    send("#{resource_name.pluralize}_scope")
  end

  # Use callbacks to share common setup or constraints between actions.
  # @return [Object]
  def set_resource(resource = nil)
    resource ||= get_scope.find(id_parameter)
    instance_variable_set("@#{resource_name}", resource)
  end

  # Allow to costomize the id parameter of finding model records
  def id_parameter
    params[:id]
  end

  # will be used to customise the key node of the data in the response
  # @return [String]
  def resource_node
    resource_name.to_s
  end

  # The singular name for the resource class based on the controller
  # @return [String]
  def resource_name
    @resource_name ||= controller_name.singularize
  end

  # The resource class based on the controller
  # @return [Class]
  def resource_class
    @resource_class ||= resource_name.classify.constantize
  end

  # Get the collection and apply the search, pagination and order
  # @return [Object]
  def get_collection
    if search_params.present?
      get_scope.ransack(search_params)
               .result
               .page(@page)
               .per(@limit)
               .order(get_order)
    else
      get_scope.page(@page)
               .per(@limit)
               .order(get_order)
    end
  end

  # Returns the resource from the created instance variable
  # @return [Object]
  def get_resource
    instance_variable_get("@#{resource_name}")
  end

  # Returns the allowed parameters for searching
  # Override this method in each API controller
  # to permit additional parameters to search on
  # @return [Hash]
  def search_params
    {}
  end

  # The pagination payload to index response
  # @return [Hash]
  def pagination(object)
    {
      pagination: {
        current_page:  object.current_page,
        next_page:     object.next_page,
        previous_page: object.prev_page,
        total_pages:   object.total_pages,
        per_page:      object.limit_value,
        total_entries: object.total_count
      }
    }
  end

  # the sort option
  def get_order
    # { sort_column => sort_direction }
  end

  # validate the given sort paratemer with model attributes or return the default
  def sort_column(default = :created_at)
    get_scope.column_names.include?(params[:sort]) ? params[:sort] : default
  end

  # validate the direction attribute
  def sort_direction(default = :asc)
    %w[asc desc].include?(params[:direction]) ? params[:direction] : default
  end

  # the default show template
  def show_template
    @access == 'admin' ? :v1_admin_show : :v1_show
  end

  # the default index template
  def index_template
    @access == 'admin' ? :v1_admin_index : :v1_index
  end

  # will be used to customise the key node of the data in the response
  # @return [String]
  def resource_node
    resource_name.to_s
  end

  # Inject acts_as_api template with scopes or extra data to be used
  # in rendering the responses
  # @return [Hash]
  def template_injector
    {}
  end

  # incase params needed to be processed or apply some
  # logic before passing to the model
  def params_processed
    resource_params
  end

  # Only allow a trusted parameter "white list" through.
  # If a single resource is loaded for #create or #update,
  # then the controller for the resource must implement
  # the method "#{resource_name}_params" to limit permitted
  # parameters for the individual model.
  def resource_params
    @resource_params ||= send("#{resource_name}_params")
  end

  # the default message of the index (with data and without)
  # @return [String]
  def index_message(collection)
    I18n.t(collection.to_a.size.zero? ? 'no_data_found' : 'data_found')
  end

  # used to customize the default messages for create, update and destroy
  def action_message
    {}
  end
end
