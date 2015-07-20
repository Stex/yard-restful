module YardRestful
  module Tags
    class StatusCodeTag < YARD::Tags::Tag
      #@resource.status_code 402 (:invalid_code) some description
      MATCH = /(\d{3})( \(([a-z0-9_]+)\))?(.*)/m

      attr_accessor :text, :status_code, :internal_code

      def initialize(tag_name, text)
        super(tag_name, nil)
        parse_tag(text)
      end

      private

      def parse_tag(text)
        match = text.match(MATCH)

        @status_code   = match[1]
        @internal_code = match[3]
        description    = match[4]

        @text = description.to_s.strip
      end

    end
  end
end