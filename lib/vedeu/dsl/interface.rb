require 'vedeu/support/common'

module Vedeu

  module DSL

    class Interface

      include Vedeu::Common
      include DSL::Colour
      include DSL::Shared
      include DSL::Style

      # Returns an instance of DSL::Interface.
      #
      # @param model [Interface]
      def initialize(model)
        @model = model
      end

      # Allows the setting of a border for the interface.
      #
      # @param block [Proc]
      # @return [Hash]
      def border(&block)
        return requires_block(__callee__) unless block_given?

        model.border = Vedeu::Border.build(model, { enabled: true }, &block)
      end

      # Set the cursor visibility on an interface.
      #
      # @param value [Boolean] Any value other than nil or false will evaluate
      #   to true.
      #
      # @example
      #   interface 'my_interface' do
      #     cursor  true  # => show the cursor for this interface
      #     cursor  :show # => both of these are equivalent to line above
      #     cursor!       #
      #     ...
      #
      #     cursor false # => hide the cursor for this interface
      #     cursor :hide # => both of these are equivalent to line above
      #     cursor nil   #
      #     ...
      #
      #   view 'my_interface' do
      #     cursor true
      #     ...
      #
      # @return [Symbol]
      def cursor(value = true)
        if value == :hide || !!value == false
          model.cursor = false

        elsif value == :show || !!value == true
          model.cursor = true

        end
      end

      def cursor!
        model.cursor = true
      end

      # To maintain performance interfaces can be delayed from refreshing too
      # often, the reduces artefacts particularly when resizing the terminal
      # screen.
      #
      # @param value [Fixnum|Float]
      #
      # @example
      #   interface 'my_interface' do
      #     delay 0.5 # interface will not update more often than every 500ms.
      #     ...
      #
      # @return [Fixnum|Float]
      def delay(value)
        model.delay = value
      end

      # Specify this interface as being in focus when the application starts.
      #
      # @note If multiple interfaces are defined, and this is included in each,
      #   then the last defined will be the interface in focus.
      #
      # @return [String] The name of the interface in focus.
      def focus!
        Vedeu::Focus.add(model.name, true) if defined_value?(model.name)
      end

      # Specify a group for an interface. Interfaces of the same group can be
      # targetted together; for example you may want to refresh multiple
      # interfaces at once.
      #
      # @param value [String]
      #
      # @example
      #   interface 'my_interface' do
      #     group 'main_screen'
      #     ...
      #
      # @return [String]
      def group(value)
        model.group = value
      end

      # Define the geometry for an interface.
      #
      # @param block [Proc]
      #
      # @example
      #   interface 'my_interface' do
      #     geometry do
      #       ...
      #
      # @return [Geometry]
      # @see Vedeu::DSL::Geometry
      def geometry(&block)
        return requires_block(__callee__) unless block_given?

        model.geometry = Vedeu::Geometry.build({}, &block)
      end

      # @see Vedeu::API#keys
      def keys(&block)
        Keymap.keys(model.name, &block)
      end

      # Specify multiple lines in a view.
      #
      # @param block [Proc]
      #
      # @example
      #   view 'my_interface' do
      #     lines do
      #       ... see {DSL::Line} and {DSL::Stream}
      #     end
      #   end
      #
      # @return [Line]
      def lines(&block)
        return requires_block(__callee__) unless block_given?

        model.lines.add(Vedeu::Line.build([], model, nil, nil, &block))
      end

      # The name of the interface. Used to reference the interface throughout
      # your application's execution lifetime.
      #
      # @param value [String]
      #
      # @example
      #   interface do
      #     name 'my_interface'
      #     ...
      #
      # @return [String]
      def name(value)
        model.name = value
      end

      # @deprecated
      # @todo Remove these methods in 0.3.0 or soon thereafter.
      # :nocov:
      def centred(value = true)
        deprecated("Vedeu::API::Interface#centred",
                   "Vedeu::DSL::Geometry#centred",
                   "0.3.0",
                   "/Vedeu/DSL/Geometry#centred-instance_method)")
      end
      alias_method :centred!, :centred

      def height(value)
        deprecated("Vedeu::API::Interface#height",
                   "Vedeu::DSL::Geometry#height",
                   "0.3.0",
                   "/Vedeu/DSL/Geometry#height-instance_method)")
      end

      def line(value = '')
        deprecated("Vedeu::DSL::Interface#line",
                   "Vedeu::DSL::Interface#lines",
                   "0.3.0",
                   "/Vedeu/DSL/Interface#lines-instance_method)")
      end

      def width(value)
        deprecated("Vedeu::API::Interface#width",
                   "Vedeu::DSL::Geometry#width",
                   "0.3.0",
                   "/Vedeu/DSL/Geometry#width-instance_method)")
      end

      def x(value = 0, &block)
        deprecated("Vedeu::API::Interface#x",
                   "Vedeu::DSL::Geometry#x",
                   "0.3.0",
                   "/Vedeu/DSL/Geometry#x-instance_method)")
      end

      def y(value = 0, &block)
        deprecated("Vedeu::API::Interface#y",
                   "Vedeu::DSL::Geometry#y",
                   "0.3.0",
                   "/Vedeu/DSL/Geometry#y-instance_method)")
      end
      # :nocov:

      private

      attr_reader :model

    end # Interface

  end # DSL

end # Vedeu
