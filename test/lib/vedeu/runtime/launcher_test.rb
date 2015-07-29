require 'test_helper'

module Vedeu

  describe Launcher do

    let(:described) { Vedeu::Launcher }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@argv').must_equal([]) }
      it { instance.instance_variable_get('@stdin').must_equal(STDIN) }
      it { instance.instance_variable_get('@stdout').must_equal(STDOUT) }
      it { instance.instance_variable_get('@stderr').must_equal(STDERR) }
      it { instance.instance_variable_get('@kernel').must_equal(Kernel) }
      it { instance.instance_variable_get('@exit_code').must_equal(1) }
    end

    describe '#debug_execute!' do
      subject { instance.debug_execute! }

      context 'when debugging is enabled in the configuration' do
        # @todo Add more tests.
        # it { skip }
      end

      context 'when debugging is not enabled in the configuration' do
        # @todo Add more tests.
        # it { skip }
      end
    end

    describe '#execute!' do
      before {
        Configuration.stubs(:configure)# .returns(test_configuration)
        Application.stubs(:start)
        Kernel.stubs(:exit)
        Kernel.stubs(:puts)
      }

      subject { instance.execute! }

      it 'returns 0 for successful execution' do
        subject.must_equal(0)
      end
    end

  end # Launcher

end # Vedeu
