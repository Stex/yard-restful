module YardRestful
  module Tags
    class ResponseFieldTag < ParamTag

      MATCH = /(<([a-zA-Z0-9_\., ]+)> )?\[([<>A-Za-z0-9_:, ]+)\] ([a-zA-Z0-9_]*@?[a-zA-Z0-9_]+)(.*)/m

      private

      def parse_tag(text)
        match = text.match(MATCH)

        #The parsed tag has parents / describes a sub param
        if match[1] =~ /^<.*> $/
          @parents = match[2].split(',').map(&:strip)
        else
          @parents = []
        end

        types, @name, description = text.match(MATCH).to_a[3..-1]

        @types       = types.split(',').map(&:strip)
        @docstring   = YARD::Docstring.new(text, nil)

        @text = description.to_s.strip
      end

    end
  end
end