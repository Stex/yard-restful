module YardRestful
  module Tags
    class UrlFieldTag < YARD::Tags::Tag
      #@resource.url <comments> commentable The commentable
      MATCH = /(<([a-zA-Z0-9_\., ]+)> )?([a-zA-Z_]+)(.*)/m

      attr_accessor :text, :parent, :name

      def initialize(tag_name, text)
        super(tag_name, nil)
        parse_tag(text)
      end

      private

      def parse_tag(text)
        @parent, @name, description = text.match(MATCH)[2..-1]
        @text = description.to_s.strip
      end

    end
  end
end