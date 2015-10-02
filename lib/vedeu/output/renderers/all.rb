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
    #   Vedeu.renderers.clear
    #
    # @return [Array<void>]
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

    # Instructs each renderer registered with Vedeu to render the
    # output as content.
    #
    # @example
    #   Vedeu.renderers.render(output)
    #
    # @param output [void]
    # @return [Array<void>]
    def render(output)
      threads = storage.map do |renderer|
        Thread.new(renderer) do
          mutex.synchronize do
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
      @storage = in_memory
    end

    private

    # @return [Set]
    def in_memory
      Set.new
    end

    # @return [Mutex]
    def mutex
      @mutex ||= Mutex.new
    end

    # @return [Set]
    def storage
      @storage ||= in_memory
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
  def_delegators Vedeu::Renderers, :renderer, :renderers

end # Vedeu

require 'vedeu/output/renderers/options'
require 'vedeu/output/renderers/escape_sequence'
require 'vedeu/output/renderers/file'
require 'vedeu/output/renderers/html'
require 'vedeu/output/renderers/json'
require 'vedeu/output/renderers/null'
require 'vedeu/output/renderers/terminal'
require 'vedeu/output/renderers/text'
