module Vedeu
  module Input
    class Translator
      class << self
        def press(key)
          new(key).translate
        end
      end

      def initialize(key)
        @key = key
      end

      def translate
        use_map
      end

      private

      attr_reader :key

      def use_map
        case key

        # code, unix, iTerm
        when 337, '^[1;2A', "^[A" then :"Shift+up"
        when 336, '^[1;2B', "^[B" then :"Shift+down"
        when 402, '^[1;2C'        then :"Shift+right"
        when 393, '^[1;2D'        then :"Shift+left"

        when 558, '^[1;3A'        then :"Alt+up"
        when 517, '^[1;3B'        then :"Alt+down"
        when 552, '^[1;3C'        then :"Alt+right"
        when 537, '^[1;3D'        then :"Alt+left"

        when 560, '^[1;5A'        then :"Ctrl+up"
        when 519, '^[1;5B'        then :"Ctrl+down"
        when 554, '^[1;5C'        then :"Ctrl+right"
        when 539, '^[1;5D'        then :"Ctrl+left"

        when 561, '^[1;6A'        then :"Ctrl+Shift+up"
        when 520, '^[1;6B'        then :"Ctrl+Shift+down"
        when 555, '^[1;6C', "^[C" then :"Ctrl+Shift+right"
        when 540, '^[1;6D', "^[D" then :"Ctrl+Shift+left"

        when 562, '^[1;7A'        then :"Alt+Ctrl+up"
        when 521, '^[1;7B'        then :"Alt+Ctrl+down"
        when 556, '^[1;7C'        then :"Alt+Ctrl+right"
        when 541, '^[1;7D'        then :"Alt+Ctrl+left"

        when      '^[1;8A'        then :"Alt+Ctrl+Shift+up"
        when      '^[1;8B'        then :"Alt+Ctrl+Shift+down"
        when      '^[1;8C'        then :"Alt+Ctrl+Shift+right"
        when      '^[1;8D'        then :"Alt+Ctrl+Shift+left"

        when      '^[1;10A'       then :"Alt+Shift+up"
        when      '^[1;10B'       then :"Alt+Shift+down"
        when      '^[1;10C'       then :"Alt+Shift+right"
        when      '^[1;10D'       then :"Alt+Shift+left"

        when      '^[F'           then :"Shift+end"
        when      '^[H'           then :"Shift+home"

        when      '^[1;9F'        then :"Alt+end"
        when      '^[1;9H'        then :"Alt+home"

        when      '^[1;10F'       then :"Alt+Shift+end"
        when      '^[1;10H'       then :"Alt+Shift+home"

        when      '^[1;13F'       then :"Alt+Ctrl+end"
        when      '^[1;13H'       then :"Alt+Ctrl+home"

        when      '^[1;14F'       then :"Alt+Ctrl+Shift+end"
        when      '^[1;14H'       then :"Alt+Ctrl+Shift+home"

        when 527                  then :"Ctrl+Shift+end"
        when 532                  then :"Ctrl+Shift+home"

        when Input::Wrapper.press_up        then :up
        when Input::Wrapper.press_down      then :down
        when Input::Wrapper.press_left      then :left
        when Input::Wrapper.press_right     then :right
        when Input::Wrapper.press_end       then :end
        when Input::Wrapper.press_home      then :home
        when Input::Wrapper.press_page_down then :page_down
        when Input::Wrapper.press_page_up   then :page_up
        when Input::Wrapper.press_insert    then :insert
        when Input::Wrapper.press_fkeys     then fkey

        # modify
        when 9                    then :tab
        when 353                  then :"Shift+tab"
        when 13                   then :enter # shadows Ctrl+m
        when 263, 127             then :backspace
        when '^[3~', Input::Wrapper.press_delete then :delete

        # misc
        when 0                    then :"Ctrl+space"
        when ctrl_key_code?       then ctrl_character
        when 27                   then :escape
        when Input::Wrapper.press_resize         then :resize
        when ascii_out_of_range?  then key
        when ascii_in_range?      then character
        when alt_key_code?        then alt_character
        else
          key
        end
      end

      def alt_character
        :"Alt+#{key.slice(1, 1)}"
      end

      def alt_key_code?
        if character? && key.to_s.slice(0, 1) == "^" && key.to_s.size == 2
          key
        else
          false
        end
      end

      def ascii_out_of_range?
        return (ascii_code? && key > 255) ? key : false
      end

      def ascii_in_range?
        return (ascii_code? && key <= 255) ? key : false
      end

      def character
        key.chr
      end

      def character?
        !ascii_code?
      end

      def ctrl_character
        :"Ctrl+#{('a'..'z').to_a.unshift(nil)[key]}"
      end

      def ctrl_key_code?
        return (ascii_code? && key.between?(1, 26)) ? key : false
      end

      def fkey
        :"F#{key - press_f0}"
      end

      def ascii_code?
        key.is_a?(Fixnum) && (key > 0) && (key < 256)
      end
    end
  end
end
