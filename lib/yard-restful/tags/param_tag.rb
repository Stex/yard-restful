module YardRestful
  module Tags
    class ParamTag < YARD::Tags::Tag
      MATCH = /(optional|required) (<([a-zA-Z0-9_\., ]+)> )?\[([<>A-Za-z0-9_:, ]+)\] ([a-zA-Z0-9_]*@?[a-zA-Z0-9_]+)(.*)/m

      attr_accessor :requirement, :name, :types, :text, :docstring, :short_name

      def initialize(tag_name, text)
        super(tag_name, nil)
        parse_tag(text)
      end

      def self.initialize_short_name_mapping!(tags)
        @@short_name_mappings = tags.inject({}) do |h, tag|
          if tag.short_name
            if h[tag.short_name]
              raise ArgumentError.new("The tag shortcut '#{tag.short_name}' was used multiple times.")
            end
            h[tag.short_name] = tag
          end
          h
        end
      end

      def required?
        requirement == 'required'
      end

      def optional?
        !required?
      end

      #
      # @return [TrueClass, FalseClass] +true+ if the given tag is
      #   one of the current tag's parents.
      #
      # This is the case if the tags namespace is one of this tag's parent namespaces
      #
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

      def single_parent?
        @parents.size == 1
      end

      #
      # @return [Array<Array<String>>] the tag name within its namespaces
      #
      # @example
      #   [['profile', 'private_profile', 'address'], ['profile', 'business_profile', 'address']]
      #
      def namespaced_names
        return [[@name.to_s]] if @parents.empty?
        parent_namespaces.map { |p| p + [@name] }
      end

      #
      # @return [Array<Array<String>>] the parent namespaces
      #
      def parent_namespaces
        @parents.map { |p| p.split('.') }
      end

      #
      # The general order that tags were added in the documentation is preserved,
      # but tags with only a single parent are more important than tags with multiple parents
      #
      # *Note*: please use Enumerable#stable_sort instead of the normal sort algorithm
      # implemented by ruby
      #
      def <=>(other_tag)
        return -1 if single_parent? && !other_tag.single_parent?
        return 1 if other_tag.single_parent? && !single_parent?
        0
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

        types, name, description = text.match(MATCH).to_a[4..-1]

        #To avoid having too long parent names in the comments, tags may be given
        #short names in the format short_name@long_name which may then be used
        #inside the <parents> declaration
        if (name_parts = name.split('@')).size > 1
          @short_name = name_parts.first
          @name       = name_parts.last
        else
          @name       = name
        end

        @types       = types.split(',').map(&:strip)
        @docstring   = YARD::Docstring.new(text, nil)

        @text = description.to_s.strip
      end

    end
  end
end