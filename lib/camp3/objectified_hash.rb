# frozen_string_literal: true

module Camp3
  # Converts hashes to the objects.
  class ObjectifiedHash
    # Creates a new ObjectifiedHash object.
    def initialize(hash)
      @hash = hash
      @data = objectify_data
    end

    # @return [Hash] The original hash.
    def to_hash
      hash
    end
    alias to_h to_hash

    # @return [String] Formatted string with the class name, object id and original hash.
    def inspect
      "#<#{self.class}:#{object_id} {hash: #{hash.inspect}}"
    end

    private

    attr_reader :hash, :data

    def objectify_data
      result = @hash.each_with_object({}) do |(key, value), data|
        value = objectify_value(value)

        data[key.to_s] = value
      end

      result
    end

    def objectify_value(input)  
      return ObjectifiedHash.new(input) if input.is_a? Hash

      return input unless input.is_a? Array

      input.map { |curr| objectify_value(curr) }
    end

    # Respond to messages for which `self.data` has a key
    def method_missing(method_name, *args, &block)
      @data.key?(method_name.to_s) ? @data[method_name.to_s] : super
    end

    def respond_to_missing?(method_name, include_private = false)
      @hash.keys.map(&:to_sym).include?(method_name.to_sym) || super
    end
  end
end