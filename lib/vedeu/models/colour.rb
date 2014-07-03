require 'virtus'

require_relative '../support/esc'
require_relative '../support/translator'

module Vedeu
  class Foreground < Virtus::Attribute; end
  class Background < Virtus::Attribute; end

  class Colour
    include Virtus.model

    attribute :foreground, Foreground
    attribute :background, Background

    # def to_compositor
    #   attributes.delete_if {|_, v| v.nil? || v.empty? }
    # end

    def to_json
      Oj.dump(attributes, mode: :compat)
    end

    def to_s
      [foreground_to_s, background_to_s].join
    end

    def empty?
      foreground.nil? && background.nil?
    end

    private

    def foreground_to_s
      return '' unless foreground

      [Esc.esc, '38;5;', escape_sequence(foreground), 'm'].join
    end

    def background_to_s
      return '' unless background

      [Esc.esc, '48;5;', escape_sequence(background), 'm'].join
    end

    def escape_sequence(value)
      Translator.translate(value)
    end
  end
end
