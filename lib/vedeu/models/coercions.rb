module Vedeu
  module Coercions
    private

    def multiple?(values)
      values.is_a?(::Array)
    end

    def single?(values)
      values.is_a?(::Hash)
    end

    def just_text?(values)
      values.is_a?(::String)
    end

    def empty?(values)
      values.nil? || values.empty?
    end
  end
end
