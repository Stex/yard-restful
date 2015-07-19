YARD::Templates::Engine.register_template_path File.dirname(__FILE__) + '/../templates'

require 'yard-restful/core_ext'
require 'yard-restful/tag_registration'
require 'yard-restful/rest_filters'
require 'yard-restful/html_blocks_helper'

YARD::Templates::Template.extra_includes << RestFilters
YARD::Templates::Template.extra_includes << ->(opts) { HtmlBlocksHelper if opts.format == :html }

module YardRestful
  def self.initialize_markdown
    renderer  = Redcarpet::Render::XHTML.new(:prettify => true)
    Redcarpet::Markdown.new(renderer, :fenced_code_blocks           => true,
                                      :disable_indented_code_blocks => true,
                                      :no_intra_emphasis            => true)
  end

end