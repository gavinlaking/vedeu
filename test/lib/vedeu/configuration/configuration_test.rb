require 'test_helper'

module Vedeu

  describe Configuration do

    let(:described) { Vedeu::Configuration }

    before { Configuration.reset! }
    after  { test_configuration }

    describe 'alias_methods' do
      it { described.must_respond_to(:debug) }
      it { described.must_respond_to(:drb) }
      it { described.must_respond_to(:interactive) }
      it { described.must_respond_to(:once) }
    end

    describe '.default_system_keys' do
      it 'returns the default system keys' do
        Configuration.default_system_keys.must_equal(exit:        'q',
                                                     focus_next:  :tab,
                                                     focus_prev:  :shift_tab,
                                                     mode_switch: :escape,)
      end
    end

    describe '#debug?' do
      it 'returns the value of the debug option' do
        Configuration.debug?.must_equal(false)
      end
    end

    describe '#drb?' do
      it 'returns the value of the drb option' do
        Configuration.drb?.must_equal(false)
      end
    end

    describe '#interactive?' do
      it 'returns the value of the interactive option' do
        Configuration.interactive?.must_equal(true)
      end
    end

    describe '#once?' do
      it 'returns the value of the once option' do
        Configuration.once?.must_equal(false)
      end
    end

    describe '#stdin' do
      it 'returns the value of the redefined STDIN' do
        Configuration.stdin.must_equal(nil)
      end
    end

    describe '#stdout' do
      it 'returns the value of the redefined STDOUT' do
        Configuration.stdout.must_equal(nil)
      end
    end

    describe '#stderr' do
      it 'returns the value of the redefined STDERR' do
        Configuration.stderr.must_equal(nil)
      end
    end

    describe '#terminal_mode' do
      it 'returns the value of the mode option' do
        Configuration.terminal_mode.must_equal(:raw)
      end
    end

    describe '.configure' do
      it 'returns the options configured' do
        Configuration.configure do
          # ...
        end.must_equal(Vedeu::Configuration)
      end
    end

  end # Configuration

end # Vedeu
