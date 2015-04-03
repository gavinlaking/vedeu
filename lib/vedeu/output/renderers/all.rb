require_relative 'file_renderer'
require_relative 'html_renderer'
require_relative 'json_renderer'
require_relative 'null_renderer'
require_relative 'terminal_renderer'

module Vedeu

  module Renderers

    extend Enumerable
    extend self

    # Provides access to the list of renderers.
    #
    # @return [Module]
    def renderers
      self
    end

    # @return [Array<void>]
    def render(*args)
      # acc = []
      threads = storage.map do |renderer|
        Thread.new(renderer) do
          mutex.synchronize do
            Vedeu.log(type: :debug, message: "Sending to renderer: '#{renderer}'")
            # acc << renderer.render(*args)
            renderer.render(*args)
          end
        end
      end
      threads.each { |t| t.join }
      # acc

      # storage.inject([]) do |acc, renderer|
      #   acc << renderer.render(*args)
      #   acc
      # end
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

    # @return [Set]
    def reset
      @storage = Set.new
    end

    # @return [Set]
    def storage
      @storage ||= reset
    end

    private

    # @return [Mutex]
    def mutex
      @mutex ||= Mutex.new
    end

  end # Renderers

end # Vedeu
