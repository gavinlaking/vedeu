module Vedeu

  class Keymaps < Repository

    # @raise [KeyInUse] The key is already defined.
    # @return [TrueClass] The key is not already defined.
    def valid?(key)
      return true unless global_key?(key) || system_key?(key)
    end

    private

    def global_key?(key)
      key_defined?('_global_', key)
    end

    def key_defined?(keymap, key)
      return false unless registered?(keymap)

      if find(keymap).key_defined?(key)
        fail KeyInUse, "'#{key}' is already in use in the '#{keymap}' keymap."

      else
        false

      end
    end

    def system_key?(key)
      key_defined?('_global_', key)
    end

  end # Keymaps

end # Vedeu
