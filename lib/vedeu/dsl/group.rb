module Vedeu

  module DSL

    # DSL for adding interfaces to a group.
    class Group

      include Vedeu::DSL

      # Specify a new group of interfaces with a simple DSL.
      #
      # The example below resembles 'vim' (the popular terminal-based text
      # editor):
      #
      # @example
      #   Vedeu.group 'title_screen' do
      #     add 'welcome_interface'
      #     # ...
      #
      #   Vedeu.group 'main_screen' do
      #     add 'editor_interface'
      #     add 'status_interface'
      #     add 'command_interface'
      #     # ...
      #
      # @note
      #   Creating a group with the same name as an existing group overwrites
      #   the existing group.
      #
      # @param name [String] The name of this group.
      # @param block [Proc]
      # @raise [InvalidSyntax] The required block was not given.
      # @return [Vedeu::Group]
      def self.group(name, &block)
        fail InvalidSyntax, 'block not given' unless block_given?

        Vedeu::Group.build({ name: name }, &block).store
      end

      # Returns an instance of DSL::Group.
      #
      # @param model [Group]
      # @param client [Object]
      # @return [Vedeu::DSL::Group]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Add the named interface to this group.
      #
      # @param interface_name [String]
      # @return [void]
      def add(interface_name)
        model.add(interface_name)
      end

      protected

      # @!attribute [r] client
      # @return [Object]
      attr_reader :client

      # @!attribute [r] model
      # @return [Group]
      attr_reader :model

    end # Group

  end # DSL

end # Vedeu
