# frozen_string_literal: true

module Vedeu

  module Input

    # You can define keymaps by name which matches a defined
    # interface. When that interface is in focus, keys pressed as part
    # of this definition will affect that interface. This allows you
    # to form context driven behaviour for your application.
    #
    class DSL

      include Vedeu::Common
      include Vedeu::DSL

      # Define actions for keypresses for when specific interfaces are
      # in focus. Unless an interface is specified, the key will be
      # assumed to be global, meaning its action will happen
      # regardless of the interface in focus.
      #
      #   Vedeu.keymap :my_interface do
      #     key('s')        { Vedeu.trigger(:save) }
      #     key('h', :left) { Vedeu.trigger(:left) }
      #     key('j', :down) { Vedeu.trigger(:down) }
      #     key('p') do
      #       # ... some code
      #     end
      #     # ... some code
      #   end
      #
      #   # or...
      #
      #   Vedeu.keys :my_interface do
      #     # ... some code
      #   end
      #
      #   # or...
      #
      #   Vedeu.interface :my_interface do
      #     keymap do
      #       # ... some code
      #     end # or...
      #
      #     keys do
      #       # ... some code
      #     end
      #   end
      #
      # @note
      #   If a keymap with this name does not already exist,
      #   pre-register it, otherwise we have no way of knowing if a
      #   key defined in the DSL for this keymap has already been
      #   registered. This protects the client application from
      #   attempting to define the same key more than once for the
      #   same keymap.
      #
      #   This is also used when defining the '_global_' keymap.
      #
      # @macro param_name
      # @macro param_block
      # @macro raise_requires_block
      # @macro raise_missing_required
      # @return [Vedeu::Input::Keymap]
      def self.keymap(name, &block)
        raise Vedeu::Error::MissingRequired unless name
        raise Vedeu::Error::RequiresBlock unless block_given?

        unless Vedeu.keymaps.registered?(name)
          Vedeu::Input::Keymap.new(name: name).store
        end

        Vedeu::Input::Keymap.build(name: name, &block).store
      end

      # Define keypress(es) to perform an action.
      #
      # @param keys [Array<String>|Array<Symbol>|String|Symbol]
      #   The key(s) pressed. Special keys can be found in
      #   {Vedeu::Input::Input#specials}. When more than one key is
      #   defined, then the extras are treated as aliases.
      # @macro param_block
      # @macro raise_invalid_syntax
      # @return [Array] A collection containing the keys minus any
      #   invalid or nil keys.
      def key(*keys, &block)
        raise Vedeu::Error::InvalidSyntax,
              'No action defined for `key`.' unless block_given?

        raise Vedeu::Error::InvalidSyntax,
              'No keypresses defined for `key`.' unless present?(keys)

        valid_keys(keys).each do |key|
          model.add(Vedeu::Input::Key.new(key, &block))
        end
      end
      alias key= key

      private

      # @param keys [Array<void>]
      # @return [Array<String|Symbol>]
      def valid_keys(keys)
        keys.compact.keep_if do |key|
          symbol?(key) || (string?(key) && present?(key))
        end
      end

    end # DSL

  end # Input

  # @api public
  # @!method keymap
  #   @see Vedeu::Input::DSL.keymap
  def_delegators Vedeu::Input::DSL,
                 :keymap

end # Vedeu
