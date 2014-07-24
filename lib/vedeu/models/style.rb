require 'vedeu/support/esc'

module Vedeu
  module Style
    def style
      @_style ||= if no_style?
        ''

      else
        @style.map { |s| Esc.string(s) }.join

      end
    end

    def style_original
      @_original ||= if no_style?
        ''

      else
        @style

      end
    end

    private

    def no_style?
      @style.nil? || @style.empty?
    end
  end
end
