require 'test_helper'

module Vedeu

  describe Launcher do

    let(:described) { Launcher.new }

    before do
      Configuration.stubs(:configure)
      Application.stubs(:start)
      Kernel.stubs(:exit)
      Kernel.stubs(:puts)
    end

    describe '#initialize' do
      it { return_type_for(described, Launcher) }
      it { assigns(described, '@argv', []) }
      it { assigns(described, '@stdin', STDIN) }
      it { assigns(described, '@stdout', STDOUT) }
      it { assigns(described, '@stderr', STDERR) }
      it { assigns(described, '@kernel', Kernel) }
      it { assigns(described, '@exit_code', 1) }
    end

    describe '#execute!' do
      it 'returns 0 for successful execution' do
        Launcher.new.execute!.must_equal(0)
      end
    end

  end # Launcher

end # Vedeu
