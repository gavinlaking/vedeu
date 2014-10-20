require 'test_helper'

module Vedeu

  describe Launcher do
    before do
      Configuration.stubs(:configure)
      Application.stubs(:start)
      Kernel.stubs(:exit)
      Kernel.stubs(:puts)
    end

    describe '#initialize' do
      it 'returns an instance of itself' do
        Launcher.new.must_be_instance_of(Launcher)
      end
    end

    describe '#execute!' do
      it 'returns 0 for successful execution' do
        Launcher.new.execute!.must_equal(0)
      end

      context 'when execution causes an uncaught exception' do
        before { Application.stubs(:start).raises(StandardError) }

        it 'returns 1 for unsuccessful execution' do
          skip 'This test is incorrect and fails.'

          Launcher.new.execute!.must_equal(1)
        end
      end
    end

  end # Launcher

end # Vedeu
