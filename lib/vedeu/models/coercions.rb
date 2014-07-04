module Vedeu
  module Coercions
    private

    def multiple?(values)
      values.is_a?(::Array) && values.size > 1
    end

    def single?(values)
      values.is_a?(::Hash) && values.one?
    end

    def just_text?(values)
      values.is_a?(::String)
    end

    def empty?(values)
      values.nil? || values.empty?
    end
  end
end
