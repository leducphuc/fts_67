module SearchConcern
  def search class_name="Object", search_params
    klass = Object.const_get class_name
    klass.search search_params
  end
end
