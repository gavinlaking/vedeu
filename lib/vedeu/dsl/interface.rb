require 'vedeu/support/common'

module Vedeu

  module DSL

    class Interface

      include Vedeu::Common
      include DSL::Colour
      include DSL::Style

      # Returns an instance of DSL::Interface.
      #
      # @param model [Interface]
      def initialize(model)
        @model = model
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
      # @return [Symbol]
      def cursor(value = true)
        if value == :hide || !!value == false
          model.set_cursor(:hide)

        elsif value == :show || !!value == true
          model.set_cursor(:show)

        end
      end
      alias_method :cursor!, :cursor

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
        set_focus
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

      def geometry(&block)
        return requires_block(__callee__) unless block_given?

        model.geometry = Vedeu::Geometry.build(attributes = {}, &block)
      end

      # @see Vedeu::API#keys
      def keys(&block)
        Keymap.keys(attributes[:name], &block)
      end

      # Specify a single line in a view.
      #
      # @param value [String]
      # @param block [Proc]
      #
      # @example
      #   view 'my_interface' do
      #     line 'This is a line of text...'
      #     line 'and so is this...'
      #     ...
      #
      #   view 'my_interface' do
      #     line do
      #       ... see {API::Line} and {API::Stream}
      #     end
      #   end
      #
      # @return [API::Line]
      def line(value = '', &block)
        if block_given?
          attributes[:lines] << API::Line
            .build({ parent: self.view_attributes }, &block)

        else
          attributes[:lines] << API::Line
            .build({ streams: { text: value }, parent: self.view_attributes })

        end
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

      # Use the specified interface; useful for sharing attributes with other
      # interfaces. Any public method of #{Vedeu::Interface} is available.
      #
      # @example
      #   interface 'my_interface' do
      #     use('my_other_interface').width # use the width of another interface
      #     ...
      #
      #   Vedeu.use('my_other_interface').width # can be used in your code to
      #                                         # get this value
      #
      # @param value [String]
      # @see Vedeu::API#use
      def use(value)
        Vedeu.use(value)
      end

      # @deprecated
      # @todo Remove these methods in 0.3.0 or soon thereafter.
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

      private

      attr_reader :model

    end # Interface

  end # DSL

end # Vedeu
