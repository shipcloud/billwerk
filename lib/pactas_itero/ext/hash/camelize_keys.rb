# frozen_string_literal: true
class Hash
  def camelize_keys(value = self)
    case value
    when Array
      value.map { |v| camelize_keys(v) }
    when Hash
      value.to_h { |k, v| [camelize_key(k), camelize_keys(v)] }
    else
      value
    end
  end

  private

  def camelize_key(key)
    case key
    when Symbol
      camelize(key.to_s).to_sym
    when String
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
