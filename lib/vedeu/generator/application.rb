require 'fileutils'

module Vedeu

  module Generator

    class Application

      # @param name [String] The name of the application.
      # @return [Vedeu::Generator::Application]
      def self.generate(name)
        new(name).generate
      end

      # @param name [String] The name of the application.
      # @return [Vedeu::Generator::Application]
      def initialize(name)
        @name = name
      end

      # @return [void]
      def generate
        copy_files
      end

      private

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      # @return [void]
      def copy_files
        FileUtils.cp_r(source, destination)
      end

      # @return [String]
      def source
        File.dirname(__FILE__) + '/templates/application/.'
      end

      # @return [String]
      def destination
        FileUtils.mkdir(name)

        name
      end

    end # Application

  end # Generator

end # Vedeu
