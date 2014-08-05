module Vedeu
  module API
    InterfaceNotSpecified = Class.new(StandardError)

    class Interface # < View (not sure...)
      def self.build(&block)
        new.build(&block)
      end

      def initialize; end

      def build(&block)
        self.instance_eval(&block) if block_given?
      end

      private

      def colour(*args)
      end

      def foreground(*args)
      end

      def background(*args)
      end

      def style(*args)
      end
    end

    class Line < Interface
      private

      def width(value)
        # Stream...
      end

      def align(value)
        # Stream...
      end

      def stream(&block)
      end

      def text(value)
      end
    end

    class Stream < Line
    end

    class View
      def self.build(implicit_name = '', &block)
        new(implicit_name).build(&block)
      end

      def initialize(implicit_name = '')
        @implicit_name = implicit_name.to_s
      end

      def build(&block)
        self.instance_eval(&block) if block_given?

        # fail Vedeu::API::InterfaceNotSpecified if name.nil? || name.empty?
        attributes
      end

      private

      attr_reader :implicit_name

      def line(&block)
        API::Line.build(&block)
      end

      def stream(&block)
        API::Stream.build(&block)
      end

      def interface(explicit_name = '')
        name = if (explicit_name.nil? || explicit_name.empty?)
          if (implicit_name.nil? || implicit_name.empty?)
            fail Vedeu::API::InterfaceNotSpecified
          else
            implicit_name
          end
        else
          explicit_name
        end

        if InterfaceStore.query(name)
          attributes[:name] = name
        end
      end

      def attributes
        @_attributes ||= {}
      end

      def valid_interface?
        return true if InterfaceStore.query(name)
      end

      # def method_missing(method, *args, &block)
      #   # @self_before_instance_eval.send method, *args, &block
      # end
    end
  end
end

require 'vedeu'

class SomeViewClass
  include Vedeu

  interface 'testing_view' do
    width  80
    height 25
    x      1
    y      1
    colour  foreground: '#ffffff', background: '#000000'
    centred true
  end

  view 'testing_view' do # argument is target interface
                         # (interface must be defined)
    line do
      text '1. Implicit target interface.'
    end
  end

  view do # lack of argument means interface attribute must be provided
    interface 'testing_view'
    line do
      text '1. Explicit target interface.'
    end
  end

  view 'testing_view' do
    line do
      text '1. A line of text.'
      text '2. Another line of text.'
    end

    line do
      text "3. These lines will split\ninternally into multiple lines."
    end
  end

  view 'testing_view' do
    line do
      text '1. Line without colours.'
    end

    line do
      colour '#ff0000', '#ffff00'
      text   '2. Line with colours.'
    end

    line do
      colour foreground: '#a7ff00', background: '#005700'
      text   '3. Line with explicit colour declaration.'
    end

    line do # actually uses streams
      foreground '#ff00ff' do
        text '4. Line with only foreground set.'
      end
    end

    line do # actually uses streams
      background '#00ff00' do
        text '5. Line with only background set.'
      end
    end
  end

  view 'testing_view' do
    line do
      style 'normal'
      text  '1. Line with a normal style.'
    end

    line do
      style 'underline'
      text  '2. Line with an underline style.'
    end

    line do # actually uses streams
      style 'normal' do
        text '3. Line with a normal style.'
      end
    end

    line do # actually uses streams
      style 'underline' do
        text '4. Line with an underlined style.'
      end
    end
  end

  view 'testing_view' do
    line do
      stream do
        text 'A stream of text.'
      end
    end

    line do
      stream do # Stream is an 'explicit declaration'.
                # We don't need it unless we want to add colours and styles.
                # See below.
        text '1. Two streams of text, these will be'
      end

      stream do
        text ' on the same line- note the space.'
      end
    end

    line do
      stream do
        text '2. Streams can have'
      end

      stream do
        colour foreground: '#ff0000', background: '#00ff00'
        text   ' colours too.'
      end
    end

    line do
      stream do
        text '3. Streams can have'
      end

      stream do
        style 'underline'
        text  ' styles too.'
      end
    end
  end

  view 'testing_view' do
    line do
      width 80
      text  'This is be aligned left, and padded with spaces.'
    end
  end

  view 'testing_view' do
    line do
      width 80
      align :left # explicit
      text  'This is be aligned left, and padded with spaces.'
    end
  end

  view 'testing_view' do
    line do
      width 80
      align :centre
      text  'This is be aligned centrally, and padded with spaces.'
    end
  end

  view 'testing_view' do
    line do
      width 80
      align :right
      text  'This is be aligned right, and padded with spaces.'
    end
  end
end

