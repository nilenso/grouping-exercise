class MatchingAttribute
  def initialize(attribute_name, options = {})
    @attribute_name = attribute_name
    @aliases = options[:aliases] || []
  end

  def keys
    [@attribute_name] + @aliases
  end
end
