module YardRestful
  module Tags
    class ParamTag < YARD::Tags::Tag
      MATCH = /(optional|required) (<([a-zA-Z0-9_\., ]+)> )?\[([<>A-Za-z0-9_:, ]+)\] ([a-zA-Z0-9_]+)(.*)/m

      attr_accessor :requirement, :name, :types, :text, :docstring

      def initialize(tag_name, text)
        super(tag_name, nil)
        parse_tag(text)
      end

      def required?
        requirement == 'required'
      end

      def optional?
        !required?
      end

      def child_of?(tag)
        return false if tag == self
        return true if tag.children.include?(self)
        tag.namespaced_names.any? { |ns| parent_namespaces.include?(ns) }
      end


      def add_child(child_tag)
        children.push(child_tag)
      end

      def children
        @children ||= []
      end

      def root_level?
        @parents.empty?
      end

      #
      # @return [Array<String>] the tag name within its namespaces
      #
      # @example
      #   [['profile', 'private_profile', 'address'], ['profile', 'business_profile', 'address']]
      #
      def namespaced_names
        return [[@name.to_s]] if @parents.empty?
        parent_namespaces.map { |p| p + [@name] }
      end

      def parent_namespaces
        @parents.map { |p| p.split('.') }
      end

      private

      def parse_tag(text)
        match = text.match(MATCH)

        @requirement = match[1]

        #The parsed tag has parents / describes a sub param
        if match[2] =~ /^<.*> $/
          @parents = match[3].split(',').map(&:strip)
        else
          @parents = []
        end

        types, @name, description = text.match(MATCH).to_a[4..-1]
        @types       = types.split(',').map(&:strip)
        @docstring   = YARD::Docstring.new(text, nil)

        @text = description.to_s.strip
      end

    end
  end
end