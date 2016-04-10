# frozen_string_literal: true

module Vedeu

  module DSL

    # DSL for creating collections of interfaces.
    #
    # Views with Vedeu are made up of simple building blocks. These
    # blocks can be arranged in a multitude of ways which I hope is
    # more than sufficient for your design needs.

    # - A view (`View`) is made up of one or more interfaces.
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
    # @api public
    #
    class View

      include Vedeu::Common
      include Vedeu::DSL

      # {include:file:docs/dsl/by_method/view.md}
      # @macro param_name
      # @macro param_block
      # @macro raise_requires_block
      # @macro raise_missing_required
      # @return [Vedeu::Views::Views<Vedeu::Views::View>]
      # @todo More documentation required.
      def view(name, &block)
        raise Vedeu::Error::RequiresBlock unless block_given?
        raise Vedeu::Error::MissingRequired,
              'Cannot add view without a name.' unless present?(name)

        new_model = Vedeu::Views::View.build(new_attributes(name), &block)

        model.add(new_model)
      end

      # {include:file:docs/dsl/by_method/template_for.md}
      # @macro param_name
      # @param filename [String] The filename (including path) to the
      #   template to be used. Yoy can use `File.dirname(__FILE__)` to
      #   use relative paths.
      # @param object [Object] The object for which the values of
      #   template's variables can be obtained.
      # @param options [Hash<Symbol => void>] See
      #   {Vedeu::DSL::Wordwrap}
      # @macro raise_missing_required
      # @return [Vedeu::Views::Views<Vedeu::Views::View>]
      # @todo More documentation required.
      def template_for(name, filename, object = nil, options = {})
        raise Vedeu::Error::MissingRequired,
              'Cannot render template without the name of the ' \
              'view.' unless present?(name)
        raise Vedeu::Error::MissingRequired,
              'Cannot render template without a ' \
              'filename.' unless present?(filename)

        options[:name] = name

        content = Vedeu::Templating::ViewTemplate.parse(object,
                                                        filename,
                                                        options)

        # lines     = Vedeu::DSL::Wordwrap.for(content, options)

        new_model = Vedeu::Views::View.build(template_attributes(name, content))

        model.add(new_model)
      end

      private

      # @macro param_name
      # @param lines [Vedeu::Views::Lines]
      # @return [Hash<Symbol => void>]
      def template_attributes(name, lines)
        new_attributes(name).merge!(value: lines)
      end

      # Return the current attributes combined with the existing
      # interface attributes defined by the interface.
      #
      # @macro param_name
      # @return [Hash<Symbol => void>]
      def new_attributes(name)
        existing_attributes(name).merge!(attributes)
      end

      # Retrieve the attributes of the interface by name.
      #
      # @macro param_name
      # @return [Hash<Symbol => void>]
      def existing_attributes(name)
        interface(name).attributes
      end

      # @macro interface_by_name
      def interface(name)
        Vedeu.interfaces.by_name(name)
      end

    end # View

  end # DSL

end # Vedeu
