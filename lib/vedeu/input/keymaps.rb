module Vedeu

  class Keymaps < Repository

    def valid?(key)
      return true unless key_defined?('_global_', key) || key_defined?('_system_', key)
    end

    private

    def key_defined?(keymap, key)
      return false unless registered?(keymap)

      if find(keymap).key_defined?(key)
        fail KeyInUse, "'#{key}' is already in use in the '#{keymap}' keymap."

      else
        false

      end
    end

  end # Keymaps

  Vedeu::Keymap.build('_global_') do
  end

  Vedeu::Keymap.build('_system_') do
  end

end # Vedeu
