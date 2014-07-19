require 'json'
require 'virtus'

require_relative '../support/esc'

module Vedeu
  class Colour
    include Virtus.model

    attribute :foreground, String, default: ''
    attribute :background, String, default: ''

    def foreground
      @fg ||= Esc.foreground_colour(css_foreground)
    end

    def background
      @bg ||= Esc.background_colour(css_background)
    end

    def css_foreground
      @foreground
    end

    def css_background
      @background
    end

    def to_json(*args)
      as_hash.to_json
    end

    def to_s
      foreground + background
    end

    def as_hash
      {
        foreground: css_foreground,
        background: css_background,
      }
    end
  end
end
