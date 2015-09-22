module Vedeu

  # Provides a single interface to all registered renderers.
  #
  module Renderers

    extend Enumerable
    extend self

    def clear
      threads = storage.map do |renderer|
        Thread.new(renderer) do
          mutex.synchronize do
            renderer.clear
          end
        end
      end
      threads.each(&:join)

      ''
    end

    # Provides access to the list of renderers.
    #
    # @example
    #   Vedeu.renderers
    #
    # @return [Module]
    def renderers
      self
    end

    # @example
    #   Vedeu.renderers.render(output)
    #
    # @param output [void]
    # @return [Array<void>]
    def render(output)
      threads = storage.map do |renderer|
        Thread.new(renderer) do
          mutex.synchronize do
            Vedeu.log(type:    :output,
                      message: "Renderer: '#{renderer.class.name}'")

            renderer.render(output)
          end
        end
      end
      threads.each(&:join)

      output
    end

    # Adds the given renderer class(es) to the list of renderers.
    #
    # @example
    #   Vedeu.renderer SomeRenderer
    #
    # @note
    #   A renderer class must respond to the '.render' class method.
    #
    # @param renderers [Class]
    # @return [Set]
    def renderer(*renderers)
      renderers.each { |renderer| storage.add(renderer) unless renderer.nil? }

      storage
    end

    # @example
    #   Vedeu.renderers.reset
    #
    # @return [Set]
    def reset
      @storage = Set.new
    end

    private

    # @return [Set]
    def storage
      @storage ||= reset
    end

    # @return [Mutex]
    def mutex
      @mutex ||= Mutex.new
    end

  end # Renderers

end # Vedeu
