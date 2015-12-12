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
      # @param name [String|Symbol] The name of the interface which
      #   this keymap relates to.
      # @param block [Proc]
      # @raise [Vedeu::Error::MissingRequired|
      #   Vedeu::Error::RequiresBlock] When a name or block
      #   respectively are not given.
      # @return [Vedeu::Input::Keymap]
      # @todo Try to remember why we need to pre-create the keymap in
      #   the repository.
      def self.keymap(name, &block)
        fail Vedeu::Error::MissingRequired unless name
        fail Vedeu::Error::RequiresBlock unless block_given?

        Vedeu::Input::Keymap.new(name: name).store

        Vedeu::Input::Keymap.build(name: name, &block).store
      end

      # Define keypress(es) to perform an action.
      #
      # @param values [Array<String>|Array<Symbol>|String|Symbol]
      #   The key(s) pressed. Special keys can be found in
      #   {Vedeu::Input::Input#specials}. When more than one key is
      #   defined, then the extras are treated as aliases.
      # @param block [Proc] The action to perform when this key is
      #   pressed. Can be a method call or event triggered.
      # @raise [Vedeu::Error::InvalidSyntax]
      #   When the required block is not given, the values parameter
      #   is undefined, or when processing the collection, a member
      #   is undefined.
      # @return [Array] A collection containing the keypress(es).
      def key(*values, &block)
        fail Vedeu::Error::InvalidSyntax,
             'No action defined for `key`.'.freeze unless block_given?

        fail Vedeu::Error::InvalidSyntax,
             'No keypress(es) defined for `key`.'.freeze unless present?(values)

        values.each do |value|
          unless present?(value)
            fail Vedeu::Error::InvalidSyntax,
                 'An invalid value for `key` was encountered.'.freeze
          end

          model.add(Vedeu::Input::Key.new(value, &block))
        end
      end
      alias_method :key=, :key

    end # DSL

  end # Input

  # @!method keymap
  #   @see Vedeu::Input::DSL.keymap
  def_delegators Vedeu::Input::DSL,
                 :keymap

end # Vedeu
