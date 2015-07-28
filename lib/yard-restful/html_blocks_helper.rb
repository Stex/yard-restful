module HtmlBlocksHelper

  def rotate(name = nil)
    @counter ||= {}
    name ||= 'odd_even'
    name = name.to_s

    @counter[name] ||= 0
    @counter[name] += 1

    elements = name.split(/[^\w]|\_/)
    @counter[name].even? ? elements[0] : elements[1]
  end

  def type_as_string(type)
    if type.resource? and type.tag(:restful_api).text
      "#{type.path.to_s.gsub(/(Controller|V\d::|Api::)/, '')} [#{type.tag(:restful_api).text}]"
    else
      type.name.to_s
    end
  end

  #
  # Renders a single resource_param_tag
  #
  def render_resource_param_tag(tag)
    @tag = tag
    erb(:resource_param_tag)
  end

  #
  # Renders a single resource_param_tag
  #
  def render_resource_response_tag(tag)
    @tag = tag
    erb(:resource_response_tag)
  end
end

