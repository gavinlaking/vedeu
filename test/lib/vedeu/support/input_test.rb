require 'test_helper'

module Vedeu
  describe Input do
    describe '.capture' do
      keypresses = {
        "\r"      => :enter,
        "\t"      => :tab,
        # "\e"      => :escape, # handled below in separate test
        "\e[A"    => :up,
        "\e[B"    => :down,
        "\e[C"    => :right,
        "\e[D"    => :left,
        "\e[5~"   => :page_up,
        "\e[6~"   => :page_down,
        "\e[H"    => :home,
        "\e[3~"   => :delete,
        "\e[F"    => :end,
        "\e[Z"    => :shift_tab,
        "\eOP"    => :f1,
        "\eOQ"    => :f2,
        "\eOR"    => :f3,
        "\eOS"    => :f4,
        "\e[15~"  => :f5,
        "\e[17~"  => :f6,
        "\e[18~"  => :f7,
        "\e[19~"  => :f8,
        "\e[20~"  => :f9,
        "\e[21~"  => :f10,
        "\e[23~"  => :f11,
        "\e[24~"  => :f12,
        "\e[1;2P" => :print_screen,
        "\e[1;2Q" => :scroll_lock,
        "\e[1;2R" => :pause_break,
        "\u007F"  => :backspace,
        "k"       => "k"
      }

      keypresses.each do |keypress, value|
        it 'triggers a :key event with the key pressed' do
          Terminal.stub :input, keypress do
            Vedeu.stub :trigger, value do
              Input.capture.must_equal(value)
            end
          end
        end
      end

      it 'switches the terminal mode when escape is pressed' do
        Terminal.stub :input, "\e" do
          Vedeu.stub :log, nil do
            proc { Input.capture }.must_raise(ModeSwitch)
          end
        end
      end
    end
  end
end
