# frozen_string_literal: true

module Utils
  module DeepCompactable
    def deep_compact(value)
      case value
      when Hash, ActiveSupport::HashWithIndifferentAccess
        compact_hash(value)
      when Array
        compact_array(value)
      else
        value
      end
    end

    private

    def compact_hash(hash)
      compacted_hash = hash.each_with_object({}.with_indifferent_access) do |(key, value), new_hash|
        compacted_value = deep_compact(value)
        new_hash[key] = compacted_value if value_present?(compacted_value)
      end
      compacted_hash.presence
    end

    def compact_array(array)
      compacted_array = array.map { |value| deep_compact(value) }.reject { |value| !value_present?(value) }
      compacted_array.presence
    end

    def value_present?(value)
      !(value.nil? || value == "" || (value.respond_to?(:empty?) && value.empty?))
    end
  end
end
