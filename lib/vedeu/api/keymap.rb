module Vedeu
  module API

    # Provides methods to be used to define keypress mapped to actions.
    class Keymap < Vedeu::Keymap

      # Define a keypress to perform an action.
      #
      # @param value [String|Symbol] The key pressed. Special keys can be
      #   found in {Vedeu::Input#specials}
      # @param block [Proc] The action to perform when this key is pressed. Can
      #   be a method call or event triggered.
      #
      # @example
      #   keys do
      #     key('s') { trigger(:save) }
      #     key('o') { trigger(:open) }
      #     ...
      #
      # @return []
      def key(value = '', &block)
        fail InvalidSyntax,
          'No action defined for `key`.' unless block_given?
        fail InvalidSyntax,
          'No keypress defined for `key`.' unless defined_value?(value)

        attributes[:keys] << { key: value, action: block }
      end

      # The interface(s) which will handle these keys.
      #
      # @param name_or_names [String|Array] The name or names of the
      # interface(s) which will handle these keys.
      #
      # @example
      #   keys do
      #     interface 'my_interface'
      #     key('s')  { :something }
      #     name      'my_keymap'
      #     ...
      #
      #   keys do
      #     interface ['main', 'other']
      #     key('s')  { :something }
      #     ...
      #
      # @return []
      def interface(name_or_names)
        attributes[:interfaces] = Array(name_or_names)
      end

    end

  end
end
