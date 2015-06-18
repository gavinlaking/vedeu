require 'fileutils'

module Vedeu

  module Generator

    class View

      # @param name [String] The name of the view.
      # @return [Vedeu::Generator::View]
      def self.generate(name)
        new(name).generate
      end

      # @param name [String] The name of the view.
      # @return [Vedeu::Generator::View]
      def initialize(name)
        @name = name
      end

      # @return [void]
      def generate
        make_interface_file

        make_template_file

        make_view_class_file
      end

      protected

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      private

      def make_interface_file
        FileUtils.cp(source + '/app/views/interfaces/name.erb',
                     name + '/app/views/interfaces/name.rb')
      end

      def make_template_file
        FileUtils.touch(name + '/app/views/templates/name.erb')
      end

      def make_view_class_file
        FileUtils.cp(source + '/app/views/name.erb',
                     name + '/app/views/name.rb')
      end

      def source
        File.dirname(__FILE__) + '/templates/application/.'
      end

    end # View

  end # Generator

end # Vedeu
