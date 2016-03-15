# frozen_string_literal: true

module Vedeu

  module Groups

    # Interfaces can be configured to be part of a named group. Once
    # an interface is a member of group, the group can be affected by
    # other controls. For example, assuming the client application is
    # a simple Git client, it may have a group called 'commit'. The
    # 'commit' group will contain the interfaces 'diff' (to show the
    # changes), 'staged' (to show which files are staged) and
    # 'unstaged'. A refresh of the 'commit' group would cause all
    # interfaces belonging to the group to refresh. Similarly,
    # showing or hiding the group would of course, show or hide the
    # interfaces of that group.
    #
    class DSL

      include Vedeu::DSL

      # Specify a new group of interfaces with a simple DSL. Creating
      # a group with the same name as an existing group overwrites the
      # existing group.
      #
      # The example below resembles 'vim' (the popular terminal-based
      # text editor):
      #
      #   Vedeu.group :title_screen do
      #     add :welcome_interface
      #     # ... some code
      #   end
      #
      #   Vedeu.group :main_screen do
      #     add :editor_interface
      #     add :status_interface
      #     add :command_interface
      #     # ... some code
      #   end
      #
      # or more succinctly:
      #
      #   Vedeu.group :main_screen do
      #     members :editor_interface,
      #             :status_interface,
      #             :command_interface
      #     # ... some code
      #   end
      #
      # or when defining an interface:
      #
      #   Vedeu.interface :some_interface do
      #     group :some_group
      #     # ... some code
      #   end
      #
      # @macro param_name
      # @macro param_block
      # @macro raise_requires_block
      # @return [Vedeu::Groups::Group]
      def self.group(name, &block)
        raise Vedeu::Error::MissingRequired unless name
        raise Vedeu::Error::RequiresBlock unless block_given?

        Vedeu::Groups::Group.build(name: name, &block).store
      end

      # Add the named interface to this group.
      #
      #   Vedeu.group :main_screen do
      #     add :editor_interface
      #   end
      #
      # @macro param_name
      # @return [Vedeu::Groups::Group]
      def add(name)
        model.add(name)
      end

      # Add the named interfaces to this group in bulk.
      #
      #   Vedeu.group :main_screen do
      #     members [:editor_interface,
      #              :some_interface,
      #              :other_interface]
      #   end
      #
      # @param names [Array<String|Symbol>]
      # @return [Array<String>]
      def members(*names)
        names.each { |name| add(name) }
      end

    end # DSL

  end # Groups

  # @api public
  # @!method group
  #   @see Vedeu::Groups::DSL.group
  def_delegators Vedeu::Groups::DSL,
                 :group

end # Vedeu
