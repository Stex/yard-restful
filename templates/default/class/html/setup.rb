def init
  @page_title = "#{object.name.to_s.gsub(/Controller/,"")} - #{options[:title]}"
  sections :header, [T('docstring'), :object_details, [:fields_list], :resource_details, [:fields_list]]
end

def resource_details
  @meths    = (object.meths.select{|x| x.has_tag? :url} || [])
  renderer  = Redcarpet::Render::XHTML.new(:prettify => true)
  @markdown = Redcarpet::Markdown.new(renderer, :fenced_code_blocks           => true,
                                                :disable_indented_code_blocks => true,
                                                :no_intra_emphasis            => true)
  erb(:resource_details)
end

