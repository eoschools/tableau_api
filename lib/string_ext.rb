# frozen_string_literal: true

# lifted from ruby
class String
  def camelcase(*separators)
    case separators.first
    when Symbol, TrueClass, FalseClass, NilClass
      first_letter = separators.shift
    end

    separators = ['_', '\s'] if separators.empty?

    str = dup

    separators.each do |s|
      str = str.gsub(/(?:#{s}+)([a-z])/) { Regexp.last_match(1).upcase }
    end

    case first_letter
    when :upper, true
      str = str.gsub(/(\A|\s)([a-z])/) { Regexp.last_match(1) + Regexp.last_match(2).upcase }
    when :lower, false
      str = str.gsub(/(\A|\s)([A-Z])/) { Regexp.last_match(1) + Regexp.last_match(2).downcase }
    end

    str
  end
end
