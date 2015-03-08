require 'fileutils'

module Vedeu

  module Generator

    class Application

      def self.generate(name)
        new(name).generate
      end

      def initialize(name)
        @name = name
      end

      def generate
        copy_files
      end

      private

      attr_reader :name

      def copy_files
        FileUtils.cp_r(source, destination)
      end

      def source
        File.dirname(__FILE__) + '/templates/application/.'
      end

      def destination
        FileUtils.mkdir(name)

        name
      end

    end # Application

  end # Generator

end # Vedeu
