module Vedeu

  module DSL

    # You can define keymaps by name which matches a defined interface. When
    # that interface is in focus, keys pressed as part of this definition will
    # affect that interface. This allows you to form context driven behaviour
    # for your application.
    #
    class Keymap

      include Vedeu::Common
      include Vedeu::DSL

      # Define actions for keypresses for when specific interfaces are in focus.
      # Unless an interface is specified, the key will be assumed to be global,
      # meaning its action will happen regardless of the interface in focus.
      #
      #   Vedeu.keymap 'some_interface' do
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
      #   Vedeu.keys 'some_interface' do
      #     # ... some code
      #   end
      #
      #   # or...
      #
      #   Vedeu.interface 'some_interface' do
      #     keymap do
      #       # ... some code
      #     end # or...
      #
      #     keys do
      #       # ... some code
      #     end
      #   end
      #
      # @param name [String] The name of the interface which this keymap relates
      #   to.
      # @param block [Proc]
      # @raise [Vedeu::Error::InvalidSyntax] The required block was not given.
      # @return [Vedeu::Input::Keymap]
      # @todo Try to remember why we need to pre-create the keymap in the
      #   repository.
      def self.keymap(name, &block)
        Vedeu::Input::Keymap.new(name: name).store

        Vedeu::Input::Keymap.build(name: name, &block).store
      end

      # Returns an instance of DSL::Keymap.
      #
      # @param model [Vedeu::Input::Keymap]
      # @param client [Object]
      # @return [Vedeu::DSL::Keymap]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Define keypress(es) to perform an action.
      #
      # @param values [Array<String>|Array<Symbol>|String|Symbol]
      #   The key(s) pressed. Special keys can be found in
      #   {Vedeu::Input::Input#specials}. When more than one key is
      #   defined, then the extras are treated as aliases.
      # @param block [Proc] The action to perform when this key is pressed. Can
      #   be a method call or event triggered.
      # @raise [Vedeu::Error::InvalidSyntax]
      #   When the required block is not given, the values parameter is
      #   undefined, or when processing the collection, a member is undefined.
      # @return [Array] A collection containing the keypress(es).
      def key(*values, &block)
        fail Vedeu::Error::InvalidSyntax,
             'No action defined for `key`.' unless block_given?

        fail Vedeu::Error::InvalidSyntax,
             'No keypress(es) defined for `key`.' unless present?(values)

        values.each do |value|
          unless present?(value)
            fail Vedeu::Error::InvalidSyntax,
                 'An invalid value for `key` was encountered.'
          end

          model.add(model.member.new(value, &block))
        end
      end
      alias_method :key=, :key

      # Define the name of the keymap.
      #
      # To only allow certain keys to work with specific interfaces, use the
      # same name as the interface.
      #
      # When the name '_global_' is used, all keys in the keymap block will be
      # available to all interfaces. Once a key has been defined in the
      # '_global_' keymap, it cannot be used for a specific interface.
      #
      #   Vedeu.keymap do
      #     name 'some_interface'
      #   end
      #
      # @param value [String]
      # @return [String]
      def name(value)
        model.name = value
      end
      alias_method :name=, :name

    end # Keymap

  end # DSL

end # Vedeu
