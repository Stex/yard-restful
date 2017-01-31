Gem::Specification.new do |s|
  s.name = 'yard-restful'
  s.version = '1.3.0'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.require_paths = ['lib']
  s.authors = ['Konstantin Rafalsky']
  s.date = '2014-02-21'
  s.description = 'A customized plugin for Yardoc that produces API documentation for Restful web services'
  s.email = ''
  s.extra_rdoc_files = [
      'README.markdown',
      'VERSION'
  ]
  s.files = [
      'Rakefile',
      'lib/yard-restful.rb',
      'lib/yard-restful/html_blocks_helper.rb',
      'lib/yard-restful/rest_filters.rb',
      'lib/yard-restful/tags.rb',
      'templates/default/class/html/fields_list.erb',
      'templates/default/class/html/header.erb',
      'templates/default/class/html/object_details.erb',
      'templates/default/class/html/resource_details.erb',
      'templates/default/class/html/setup.rb',
      'templates/default/docstring/html/setup.rb',
      'templates/default/docstring/html/text.erb',
      'templates/default/fulldoc/html/css/custom.css',
      'templates/default/fulldoc/html/frames.erb',
      'templates/default/fulldoc/html/full_list_object.erb',
      'templates/default/fulldoc/html/full_list_resource.erb',
      'templates/default/fulldoc/html/js/rest_plugin.js',
      'templates/default/fulldoc/html/setup.rb',
      'templates/default/layout/html/footer.erb',
      'templates/default/layout/html/index.erb',
      'templates/default/layout/html/layout.erb',
      'templates/default/layout/html/setup.rb'
  ]
  s.homepage = 'https://github.com/kraft001/yard-restful'
  s.rubygems_version = '2.2.1'
  s.summary = 'Yardoc plugin for Restful web services'

  s.add_dependency 'redcarpet', '~> 3'
  s.add_dependency 'activesupport', '> 2'
  s.add_dependency 'yard', '< 1.0'
end

