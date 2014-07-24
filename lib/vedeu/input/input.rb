require_relative '../support/terminal'
require_relative '../../vedeu'

module Vedeu
  class Input
    def self.capture
      new.capture
    end

    def capture
      Vedeu.trigger(:_keypress_, keypress)
    end

    private

    def input
      @_input ||= Terminal.input
    end

    def keypress
      key        = input
      translated = case key
      when "\r"      then :enter
      when "\t"      then :tab
      when "\e"      then :escape
      when "\e[A"    then :up
      when "\e[B"    then :down
      when "\e[C"    then :right
      when "\e[D"    then :left
      when "\e[5~"   then :page_up
      when "\e[6~"   then :page_down
      when "\e[H"    then :home
      when "\e[3~"   then :delete
      when "\e[F"    then :end
      when "\eOP"    then :f1
      when "\eOQ"    then :f2
      when "\eOR"    then :f3
      when "\eOS"    then :f4
      when "\e[15~"  then :f5
      when "\e[17~"  then :f6
      when "\e[18~"  then :f7
      when "\e[19~"  then :f8
      when "\e[20~"  then :f9
      when "\e[21~"  then :f10
      when "\e[23~"  then :f11
      when "\e[24~"  then :f12
      when "\e[1;2P" then :print_screen
      when "\e[1;2Q" then :scroll_lock
      when "\e[1;2R" then :pause_break
      when "\u007F"  then :backspace
      else
        key
      end

      translated
    end
  end
end
