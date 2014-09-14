require 'test_helper'

module Vedeu
  describe Configuration do
    before { Configuration.reset }
    after  { Configuration.reset }

    describe '#colour_mode' do
      it 'returns the value of the colour_mode option' do
        ENV['VEDEU_TERM'] = 'xterm-truecolor'
        Configuration.colour_mode.must_equal(16777216)
      end

      it '--colour-mode' do
        Configuration.configure(['--colour-mode', '16777216'])
        Configuration.colour_mode.must_equal(16777216)
      end

      it '--colour-mode' do
        Configuration.configure(['--colour-mode', '256'])
        Configuration.colour_mode.must_equal(256)
      end

      it '--colour-mode' do
        Configuration.configure(['--colour-mode', '16'])
        Configuration.colour_mode.must_equal(16)
      end

      it '--colour-mode' do
        Configuration.configure(['--colour-mode', '348'])
        Configuration.colour_mode.must_equal(8)
      end
    end

    describe '#debug?' do
      it 'returns the value of the debug option' do
        Configuration.debug?.must_equal(false)
      end

      it '--debug' do
        Configuration.configure(['--debug'])
        Configuration.debug?.must_equal(true)
      end
    end

    describe '#interactive?' do
      it 'returns the value of the interactive option' do
        Configuration.interactive?.must_equal(true)
      end

      it '--interactive' do
        Configuration.configure(['--interactive'])
        Configuration.interactive?.must_equal(true)
      end

      it '--noninteractive' do
        Configuration.configure(['--noninteractive'])
        Configuration.interactive?.must_equal(false)
      end

      it '--standalone' do
        Configuration.configure(['--standalone'])
        Configuration.interactive?.must_equal(false)
      end
    end

    describe '#once?' do
      it 'returns the value of the once option' do
        Configuration.once?.must_equal(false)
      end

      it '--run-once' do
        Configuration.configure(['--run-once'])
        Configuration.once?.must_equal(true)
      end

      it '--run-many' do
        Configuration.configure(['--run-many'])
        Configuration.once?.must_equal(false)
      end
    end

    describe '#terminal_mode' do
      it 'returns the value of the mode option' do
        Configuration.terminal_mode.must_equal(:raw)
      end

      it '--cooked' do
        Configuration.configure(['--cooked'])
        Configuration.terminal_mode.must_equal(:cooked)
      end

      it '--raw' do
        Configuration.configure(['--raw'])
        Configuration.terminal_mode.must_equal(:raw)
      end
    end

    describe '#trace?' do
      it 'returns the value of the trace option' do
        Configuration.trace?.must_equal(false)
      end

      it '--trace' do
        Configuration.configure(['--trace'])
        Configuration.trace?.must_equal(true)
      end
    end

    describe '#options' do
      it 'returns the options configured' do
        Configuration.options.must_equal(
          {
            colour_mode:   16777216,
            debug:         false,
            interactive:   true,
            once:          false,
            system_keys:   {
              exit:        "q",
              focus_next:  :tab,
              focus_prev:  :shift_tab,
              mode_switch: :escape
            },
            terminal_mode: :raw,
            trace:         false
          }
        )
      end
    end

    describe 'exploring multiple options set' do
      it 'returns the options correctly configured' do
        Configuration.configure(['--standalone', '--run-once'])
        Configuration.options.must_equal(
          {
            interactive: false,
            once: true,
            colour_mode: 16777216,
            debug: false,
            system_keys:   {
              exit:        "q",
              focus_next:  :tab,
              focus_prev:  :shift_tab,
              mode_switch: :escape
            },
            terminal_mode: :raw,
            trace: false
          }
        )
      end
    end

  end
end
