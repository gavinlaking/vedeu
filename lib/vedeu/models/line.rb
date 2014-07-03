require 'virtus'

require_relative 'presentation'
require_relative 'stream'

module Vedeu
  class Line
    include Virtus.model
    include Presentation

    attribute :streams, Array[Stream]

    # def to_compositor
    #   [
    #     formatting, *stream.map(&:to_compositor)
    #   ]
    # end

    def to_json
      Oj.dump(attributes, mode: :compat)
    end

    def to_s
      [style.to_s, colour.to_s, *streams.map(&:to_s)].join
    end

    private

    def formatting
      {
        style:  style_to_compositor,
        colour: colour_to_compositor
      }.delete_if { |_, v| v.nil? || v.empty? }
    end

    def style_to_compositor
      return '' if style.nil? || style.empty?

      style.to_compositor
    end

    def colour_to_compositor
      return '' if colour.nil? || colour.empty?

      colour.to_compositor
    end
  end
end
