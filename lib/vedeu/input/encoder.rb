module Vedeu
  class Encoder
    class << self
      def convert(key)
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

    def mapper
      {
        '\eOP'      => :f1,
        '\eOQ'      => :f2,
        '\eOR'      => :f3,
        '\eOS'      => :f4,
        '\e[15~'    => :f5,
        '\e[17~'    => :f6,
        '\e[18~'    => :f7,
        '\e[19~'    => :f8,
        '\e[20~'    => :f9,
        '\e[21~'    => :f10,
        '\e[23~'    => :f11,
        '\e[24~'    => :f12,
        '\e[1;2P'   => :f13,
        '\e[1;2Q'   => :f14,
        '\e[1;2R'   => :f15,
        '\e[1;2S'   => :f16,
        '\e[15;2~'  => :f17,
        '\e[17;2~'  => :f18,
        '\e[18;2~'  => :f19,
        '\e[19;2~'  => :f20,
        '\e[A'      => :up,
        '\e[B'      => :down,
        '\e[C'      => :right,
        '\e[D'      => :left,
        '^[3~'      => :delete,
        # '^[?~'    => :fn,
        '\e[H'      => :home,
        '\e[F'      => :end,
        '\e5~'      => :page_up,
        '\e6~'      => :page_down,
        '\t'        => :tab,
        '\e'        => :escape,
        '\r'        => :return,
      }
    end




    def use_map
      case key
      when '\eOP'     then :f1
      when '\eOQ'     then :f2
      when '\eOR'     then :f3
      when '\eOS'     then :f4
      when '\e[15~'   then :f5
      when '\e[17~'   then :f6
      when '\e[18~'   then :f7
      when '\e[19~'   then :f8
      when '\e[20~'   then :f9
      when '\e[21~'   then :f10
      when '\e[23~'   then :f11
      when '\e[24~'   then :f12
      when '\e[1;2P'  then :f13
      when '\e[1;2Q'  then :f14
      when '\e[1;2R'  then :f15
      when '\e[1;2S'  then :f16
      when '\e[15;2~' then :f17
      when '\e[17;2~' then :f18
      when '\e[18;2~' then :f19
      when '\e[19;2~' then :f20

      when '\e[A'     then :up
      when '\e[B'     then :down
      when '\e[C'     then :right
      when '\e[D'     then :left

      when '^[3~'     then :delete
      # when '^[?~'   then :fn
      when '\e[H'     then :home
      when '\e[F'     then :end
      when '\e5~'     then :page_up
      when '\e6~'     then :page_down

      when '\t'       then :tab
      when '\e'       then :escape
      when '\r'       then :return










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

      # modify

      when 353                  then :"Shift+tab"
      when 13                   then :enter # shadows Ctrl+m
      when 263, 127             then :backspace
      when '^[3~'               then :delete

      # misc
      when 0                    then :"Ctrl+space"
      when ctrl_key_code?       then ctrl_character
      when 27                   then :escape
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

    def ascii_code?
      key.is_a?(Fixnum) && (key > 0) && (key < 256)
    end
  end
end

# control_characters = [
#   "^@", "^A", "^B", "^C", "^D",  "^E", "^F", "^G", # 01 - 08
#   "^H", "^I", "^J", "^K", "^L",  "^M", "^N", "^O", # 09 - 0F
#   "^P", "^Q", "^R", "^S", "^T",  "^U", "^V", "^W", # 10 - 17
#   "^X", "^Y", "^Z", "^[", "^\\", "^]", "^^", "^_"  # 18 - 1F
# ]

# printable_characters = [
#   "<sp>", "!", "\"", "#", "$",  "%", "&", "'",     # 20 -
#   "(",    ")", "*",  "+", ",",  "-", ".", "/",
#   "0",    "1", "2",  "3", "4",  "5", "6", "7",
#   "8",    "9", ":",  ";", "<",  "=", ">", "?",
#   "@",    "A", "B",  "C", "D",  "E", "F", "G",
#   "H",    "I", "J",  "K", "L",  "M", "N", "O",
#   "P",    "Q", "R",  "S", "T",  "U", "V", "W",
#   "X",    "Y", "Z",  "[", "\\", "]", "^", "_",
#   "`",    "a", "b",  "c", "d",  "e", "f", "g",
#   "h",    "i", "j",  "k", "l",  "m", "n", "o",
#   "p",    "q", "r",  "s", "t",  "u", "v", "w",
#   "x",    "y", "z",  "{", "|",  "}", "~",
# ]

# delete_characters = [
#   "^?"
# ]



# VISIBLE_CHAR = {}
# [


#     "M-^@", "M-^A", "M-^B", "M-^C", "M-^D", "M-^E", "M-^F", "M-^G",
#     "M-^H", "M-^I", "M-^J", "M-^K", "M-^L", "M-^M", "M-^N", "M-^O",
#     "M-^P", "M-^Q", "M-^R", "M-^S", "M-^T", "M-^U", "M-^V", "M-^W",
#     "M-^X", "M-^Y", "M-^Z", "M-^[", "M-^\\", "M-^]", "M-^^", "M-^_",
#     "M-<sp>", "M-!", "M-\"", "M-#", "M-$", "M-%", "M-&", "M-'",
#     "M-(", "M-)", "M-*", "M-+", "M-,", "M--", "M-.", "M-/",
#     "M-0", "M-1", "M-2", "M-3", "M-4", "M-5", "M-6", "M-7",
#     "M-8", "M-9", "M-:", "M-;", "M-<", "M-=", "M->", "M-?",
#     "M-@", "M-A", "M-B", "M-C", "M-D", "M-E", "M-F", "M-G",
#     "M-H", "M-I", "M-J", "M-K", "M-L", "M-M", "M-N", "M-O",
#     "M-P", "M-Q", "M-R", "M-S", "M-T", "M-U", "M-V", "M-W",
#     "M-X", "M-Y", "M-Z", "M-[", "M-\\", "M-]", "M-^", "M-_",
#     "M-`", "M-a", "M-b", "M-c", "M-d", "M-e", "M-f", "M-g",
#     "M-h", "M-i", "M-j", "M-k", "M-l", "M-m", "M-n", "M-o",
#     "M-p", "M-q", "M-r", "M-s", "M-t", "M-u", "M-v", "M-w",
#     "M-x", "M-y", "M-z", "M-{", "M-|", "M-}", "M-~", "M-^?",
# ].each_with_index {|s, i|
#     VISIBLE_CHAR[i] = s
#     VISIBLE_CHAR[[i].pack("C")] = s
# }

# puts VISIBLE_CHAR.inspect
