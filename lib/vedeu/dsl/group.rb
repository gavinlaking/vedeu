module Vedeu

  module DSL

    # Interfaces can be configured to be part of a named group. Once an
    # interface is a member of group, the group can be affected by other
    # controls. For example, assuming the client application is a simple Git
    # client, it may have a group called 'commit'. The 'commit' group will
    # contain the interfaces 'diff' (to show the changes), 'staged' (to show
    # which files are staged) and 'unstaged'. A refresh of the 'commit' group
    # would cause all interfaces belonging to the group to refresh. Similarly,
    # showing or hiding the group would of course, show or hide the interfaces
    # of that group.
    #
    class Group

      include Vedeu::DSL

      # Specify a new group of interfaces with a simple DSL. Creating a group
      # with the same name as an existing group overwrites the existing group.
      #
      # The example below resembles 'vim' (the popular terminal-based text
      # editor):
      #
      #   Vedeu.group 'title_screen' do
      #     add 'welcome_interface'
      #     # ... some code
      #   end
      #
      #   Vedeu.group 'main_screen' do
      #     add 'editor_interface'
      #     add 'status_interface'
      #     add 'command_interface'
      #     # ... some code
      #   end
      #
      # or more succinctly:
      #
      #   Vedeu.group 'main_screen' do
      #     members 'editor_interface', 'status_interface', 'command_interface'
      #     # ... some code
      #   end
      #
      # or when defining an interface:
      #
      #   Vedeu.interface 'some_interface' do
      #     group 'some_group'
      #     # ... some code
      #   end
      #
      # @param name [String] The name of this group.
      # @param block [Proc]
      # @raise [Vedeu::InvalidSyntax] The required block was not given.
      # @return [Vedeu::Group]
      def self.group(name, &block)
        fail Vedeu::InvalidSyntax, 'block not given' unless block_given?

        Vedeu::Group.build(name: name, &block).store
      end

      # Returns an instance of DSL::Group.
      #
      # @param model [Vedeu::Group]
      # @param client [Object]
      # @return [Vedeu::DSL::Group]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Add the named interface to this group.
      #
      #   Vedeu.group 'main_screen' do
      #     add 'editor_interface'
      #   end
      #
      # @param interface_name [String]
      # @return [Vedeu::Group]
      def add(interface_name)
        model.add(interface_name)
      end

      # Add the named interfaces to this group in bulk.
      #
      #   Vedeu.group 'main_screen' do
      #     members ['editor_interface', 'some_interface', 'other_interface']
      #   end
      #
      # @param interface_names [Array<String>]
      # @return [Array<String>]
      def members(*interface_names)
        interface_names.each { |name| add(name) }
      end

    end # Group

  end # DSL

end # Vedeu
