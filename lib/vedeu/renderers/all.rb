module Vedeu

  # Provides a single interface to all registered renderers.
  #
  module Renderers

    extend Enumerable
    extend self

    # Instructs each renderer registered with Vedeu to clear their
    # content.
    #
    # @example
    #   Vedeu.clear
    #   Vedeu.trigger(:_clear_)
    #   Vedeu.renderers.clear
    #
    # @return [Array<void>]
    def clear
      storage.map do |renderer|
        log('Clearing', renderer)

        threaded(renderer) { renderer.clear }
      end.each(&:join) if Vedeu.ready?

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

    # Instructs each renderer registered with Vedeu to render the
    # output as content.
    #
    # @example
    #   Vedeu.renderers.render(output)
    #
    # @param output [void]
    # @return [Array<void>]
    def render(output)
      storage.map do |renderer|
        log('Rendering', renderer)

        threaded(renderer) { renderer.render(output) }
      end.each(&:join) if Vedeu.ready?

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
    #   Vedeu.renderers.reset!
    #
    # @return [Set]
    def reset!
      @storage = in_memory
    end
    alias_method :reset, :reset!

    private

    # @return [Set]
    def in_memory
      Set.new
    end

    # @param message [String]
    # @param renderer [Class]
    # @return [void]
    def log(message, renderer)
      Vedeu.log(type:    :render,
                message: "#{message} via #{renderer.class.name}".freeze)
    end

    # @return [Mutex]
    def mutex
      @mutex ||= Mutex.new
    end

    # @return [Set]
    def storage
      @storage ||= in_memory
    end

    # @return [void]
    def threaded(renderer)
      Thread.new(renderer) do
        mutex.synchronize do
          toggle_cursor do
            yield
          end
        end
      end
    end

    # @return [void]
    def toggle_cursor
      Vedeu.trigger(:_hide_cursor_)

      yield

      Vedeu.trigger(:_show_cursor_)
    end

  end # Renderers

  # @example
  #   Vedeu.renderer
  #   Vedeu.renderers
  #
  # @!method renderer
  #   @see Vedeu::Renderers#renderer
  # @!method renderers
  #   @see Vedeu::Renderers#renderers
  def_delegators Vedeu::Renderers,
                 :renderer,
                 :renderers

end # Vedeu

require 'vedeu/renderers/options'
require 'vedeu/renderers/file'
require 'vedeu/renderers/html'
require 'vedeu/renderers/json'
require 'vedeu/renderers/terminal'
