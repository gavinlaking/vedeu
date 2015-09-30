module Vedeu

  module DSL

    # DSL for creating collections of interfaces.
    #
    # Views with Vedeu are made up of simple building blocks. These
    # blocks can be arranged in a multitude of ways which I hope is
    # more than sufficient for your design needs.

    # - A view (`Composition`) is made up of one or more interfaces.
    # - An interface is an area on the screen where you can take input
    #   or direct output. You will define it's colour and style, its
    #   dimensions, including position and give it a name. You can
    #   then direct the output of a command, or event, to this
    #   interface and Vedeu will ensure the content is placed there.
    # - Interfaces (`Interface`) are made up of lines (`Line`), their
    #   length being the width of the interface and their number being
    #   the height of the interface.
    # - An interface with `width: 12, height: 5` will have five lines,
    #   each made of 12 characters- providing 60 cells. Colours and
    #   styles are handled by terminal escape sequences and therefore
    #   do not consume a cell.
    # - Lines are made up of zero, one or multiple streams which are
    #   basically subsets of the line.
    # - An interface, line or stream can have a colour attribute.
    # - An interface, line or stream can have a style attribute.
    # - Interfaces have a position (`y`, `x`) on the screen, and a
    #   size. (`width`, `height`)
    # - Interfaces can be placed relative to each other based on their
    #   attributes.
    #   - An interface has a `top`, `right`, `bottom`, `left`.
    #   - An interface also has a `north` and `west` (`top` and `left`
    #     minus 1 respectively).
    #   - An interface also has a `south` and `east` (`bottom` and
    #     `right` plus 1 respectively).
    # - Colours are defined in CSS-style values, i.e. `#ff0000` would
    #   be red.
    # - Styles are named. See the table below for supported styles.
    #
    class Composition

      include Vedeu::DSL

      # Define a view.
      #
      # A view is just an Interface object.
      #
      # When a view already exists, we take its attributes and use
      # them as the basis for the newly defined view. This way we
      # don't need to specify everything again.
      #
      # @todo More documentation required.
      # @param name [String|Symbol] The name of the interface you are
      #   targetting for this view.
      # @param block [Proc] The directives you wish to send to this
      #   interface.
      #
      # @example
      #   view :my_interface do
      #     # ...
      #   end
      #
      # @raise [Vedeu::Error::RequiresBlock]
      # @return [Vedeu::Views::Views<Vedeu::Views::View>]
      def view(name = '', &block)
        fail Vedeu::Error::RequiresBlock unless block_given?

        new_model = model.member.build(new_attributes(name), &block)

        model.add(new_model)
      end

      # Load content from an ERb template.
      #
      # @example
      #   Vedeu.renders do
      #     template_for(:my_interface,
      #                  '/path/to/template.erb',
      #                  @some_object, options)
      #   end
      #
      # @todo More documentation required.
      #
      # @param name [String|Symbol] The name of interface for which this
      #   template's content belongs to.
      # @param filename [String] The filename (including path) to the
      #   template to be used. Yoy can use `File.dirname(__FILE__)` to
      #   use relative paths.
      # @param object [Object] The object for which the values of
      #   template's variables can be obtained.
      # @param options [Hash] See {Vedeu::Output::Wordwrap}
      # @raise [Vedeu::Error::MissingRequired]
      # @return [Vedeu::Views::Views<Vedeu::Views::View>]
      def template_for(name, filename, object = nil, options = {})
        fail Vedeu::Error::MissingRequired,
             'Cannot render template without the name of the view.' unless name
        fail Vedeu::Error::MissingRequired,
             'Cannot render template without a filename.' unless filename

        options.merge!(name: name)

        content = Vedeu::Templating::ViewTemplate.parse(object,
                                                        filename,
                                                        options)

        # lines     = Vedeu::Output::Wordwrap.for(content, options)

        new_model = model.member.build(template_attributes(name, content))

        model.add(new_model)
      end

      private

      # @param name [String|Symbol]
      # @param lines [Vedeu::Views::Lines]
      # @return [Hash]
      def template_attributes(name, lines)
        new_attributes(name).merge!(value: lines)
      end

      # Return the current attributes combined with the existing
      # interface attributes defined by the interface.
      #
      # @param name [String|Symbol] The name of the interface.
      # @return [Hash]
      def new_attributes(name)
        attributes.merge!(existing_attributes(name))
      end

      # Retrieve the attributes of the interface by name.
      #
      # @param name [String|Symbol] The name of the interface.
      # @return [Hash]
      def existing_attributes(name)
        Vedeu.interfaces.by_name(name).attributes
      end

    end # Composition

  end # DSL

end # Vedeu
