class Hash
  def camelize_keys(value = self)
    case value
    when Array
      value.map { |v| camelize_keys(v) }
    when Hash
      Hash[value.map { |k, v| [camelize_key(k), camelize_keys(v)] }]
    else
      value
    end
  end

  private

  def camelize_key(key)
    if key.is_a? Symbol
      camelize(key.to_s).to_sym
    elsif key.is_a? String
      camelize(key)
    else
      key
    end
  end

  # copied from ActiveSupport
  def camelize(term)
    string = term.to_s
    string = string.sub(/^[a-z\d]*/) { $&.capitalize }
    string.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.gsub("/", "::")
  end
end
