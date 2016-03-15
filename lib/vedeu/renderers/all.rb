# frozen_string_literal: true

module Vedeu

  # Provides a single interface to all registered renderers.
  #
  module Renderers

    extend Enumerable
    extend self
    extend Vedeu::Repositories::Storage

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
        Vedeu.log(type:    :render,
                  message: "Clearing via #{renderer.class.name}")

        perform(renderer) { renderer.clear }
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
        Vedeu.log(type:    :render,
                  message: "Rendering via #{renderer.class.name}")

        perform(renderer) { renderer.render(output) }
      end.each(&:join) if Vedeu.ready?

      output
    end

    private

    # @return [Set]
    def in_memory
      if Vedeu.config.renderers.any?
        Set.new(Vedeu.config.renderers)

      else
        Set.new([Vedeu::Renderers::Terminal.new])

      end
    end

    # @param renderer [void]
    # @macro param_block
    def perform(renderer, &block)
      if Vedeu.config.threaded?
        threaded(renderer) { yield }

      else
        unthreaded { yield }

      end
    end

    # @return [Mutex]
    def mutex
      @_mutex ||= Mutex.new
    end

    # @macro param_block
    # @return [void]
    def threaded(renderer, &block)
      Thread.new(renderer) do
        mutex.synchronize do
          toggle_cursor do
            yield
          end
        end
      end
    end

    # @macro param_block
    # @return [void]
    def toggle_cursor(&block)
      Vedeu.trigger(:_hide_cursor_)

      yield

      Vedeu.trigger(:_show_cursor_)
    end

    # @macro param_block
    # @return [void]
    def unthreaded(&block)
      toggle_cursor do
        yield
      end
    end

  end # Renderers

  # @example
  #   Vedeu.renderers
  #
  # @api public
  # @!method renderers
  #   @see Vedeu::Renderers#renderers
  def_delegators Vedeu::Renderers,
                 :renderers

end # Vedeu

require 'vedeu/renderers/support/options'
require 'vedeu/renderers/support/file'

require 'vedeu/renderers/escape'
require 'vedeu/renderers/html'
require 'vedeu/renderers/json'
require 'vedeu/renderers/terminal'
require 'vedeu/renderers/text'
