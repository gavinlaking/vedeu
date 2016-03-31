# frozen_string_literal: true

module Vedeu

  module Editor

    # Handles keypresses for a named document whilst the terminal is
    # in fake mode.
    #
    # @api private
    #
    class Editor

      extend Forwardable

      def_delegators :document,
                     :clear,
                     :delete_character,
                     :delete_line,
                     :down,
                     :insert_character,
                     :insert_line,
                     :left,
                     :render,
                     :reset!,
                     :execute,
                     :right,
                     :up

      # Send given input to the named document.
      #
      # @param (see #initialize)
      # @return (see #keypress)
      def self.keypress(input:, name:)
        new(input: input, name: name).keypress
      end

      # Returns a new instance of Vedeu::Editor::Editor.
      #
      # @macro param_name
      # @param input [String|Symbol]
      # @return [Vedeu::Editor::Editor]
      def initialize(input:, name:)
        @input = input
        @name  = name
      end

      # Send given input to the named document.
      #
      # @return [String|Symbol]
      def keypress
        return input unless document

        case input
        when :backspace then delete_character
        when :delete    then delete_line
        when :ctrl_c    then Vedeu.trigger(:_exit_)
        when :down      then down
        when :enter     then insert_line
        when :escape    then Vedeu.trigger(:_mode_switch_)
        when :left      then left
        when :right     then right
        when :tab       then execute
        when :up        then up
        else
          insert_character(input)
        end
      end

      protected

      # @!attribute [r] input
      # @return [Symbol|String]
      attr_reader :input

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      private

      # @macro document_by_name
      def document
        @document ||= Vedeu.documents.by_name(name)
      end

    end # Editor

  end # Editor

end # Vedeu
