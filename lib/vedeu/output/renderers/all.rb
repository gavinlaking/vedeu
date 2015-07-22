require 'vedeu/output/renderers/renderer_options'
require 'vedeu/output/renderers/escape_sequence'
require 'vedeu/output/renderers/file'
require 'vedeu/output/renderers/html'
require 'vedeu/output/renderers/json'
require 'vedeu/output/renderers/null'
require 'vedeu/output/renderers/terminal'
require 'vedeu/output/renderers/text'

module Vedeu

  # Provides a single interface to all registered renderers.
  #
  module Renderers

    extend Enumerable
    extend self

    # Provides access to the list of renderers.
    #
    # @example
    #   Vedeu.renderers
    #
    # @api public
    # @return [Module]
    def renderers
      self
    end

    # @example
    #   Vedeu.renderers.render(output)
    #
    # @api public
    # @param output [void]
    # @return [Array<void>]
    def render(output)
      threads = storage.map do |renderer|
        Thread.new(renderer) do
          mutex.synchronize do
            Vedeu.log(type:    :debug,
                      message: "Renderer: '#{renderer.class.name}'")

            renderer.render(output)
          end
        end
      end
      threads.each(&:join)
    end

    # Adds the given renderer class(es) to the list of renderers.
    #
    # @example
    #   Vedeu.renderer SomeRenderer
    #
    # @note
    #   A renderer class must respond to the '.render' class method.
    #
    # @api public
    # @param renderers [Class]
    # @return [Set]
    def renderer(*renderers)
      renderers.each { |renderer| storage.add(renderer) unless renderer.nil? }

      storage
    end

    # @example
    #   Vedeu.renderers.reset
    #
    # @api public
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
