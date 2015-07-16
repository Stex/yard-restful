include Helpers::FilterHelper

def init
  @page_title = options[:title]
  if object == "_index.html"

  elsif object.name == :root
    sections :layout, [:index]
  else
    super
  end
end

def stylesheets
  super + %w(css/custom.css)
end

def javascripts
  super + %w(js/rest_plugin.js)
end

def menu_lists
  [
    { :type => 'resource', :title => "Resources", :search_title => "Resources" },
    { :type => 'object', :title => "Objects", :search_title => "Objects" }
  ]
end

def index
  @readme = options[:readme]
  @resources = select_resources(@objects)
  @markdown = YardRestful.initialize_markdown
  erb(:index)
end
