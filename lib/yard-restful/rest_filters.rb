module YARD
    module CodeObjects
      class Base
        def restful?
          has_tag?(:restful_api)
        end
        def resource?
          meths.any?{ |m| m.has_tag?(:url) }
        end
      end
    end
end

module RestFilters

  def select_restful(list)
    (list || []).select(&:restful?)
  end

  def select_objects(list)
    select_restful(list).reject(&:resource?).sort_by {|o| namespaced_name(o)}
  end

  def select_resources(list)
    select_restful(list).select(&:resource?).sort_by {|o| namespaced_name(o)}
  end

  def namespaced_name(obj)
    "#{obj.path.to_s.gsub(/(Controller|V\d::|Api::)/, '')}"
  end

end

