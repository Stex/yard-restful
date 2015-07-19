def init
  @markdown = YardRestful.initialize_markdown
  @page_title = "#{object.name.to_s.gsub(/Controller/,"")} - #{options[:title]}"
  sections :header, [T('docstring'), :object_details, [:fields_list], :resource_details, [:fields_list]]
end

def resource_details
  @meths    = (object.meths.select{|x| x.has_tag? :url} || [])

  @resource_tag_hierarchy = @meths.inject({}) do |h, meth|
    h[meth] = []
    param_tags = meth.tags('resource.param')
    param_tags.each do |tag|
      children = param_tags.select { |t| t.child_of?(tag) }
      children.each { |c| tag.add_child(c) }
      h[meth] << tag if tag.root_level?
    end
    h.delete(meth) if h[meth].empty?
    h
  end

  erb(:resource_details)
end

def object_details
  @meths    = object.meths
  erb(:object_details)
end

