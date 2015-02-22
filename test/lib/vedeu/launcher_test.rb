require 'test_helper'

module Vedeu

  describe Launcher do

    let(:described) { Vedeu::Launcher }
    let(:instance)  { described.new }

    before do
      Configuration.stubs(:configure)#.returns(test_configuration)
      Application.stubs(:start)
      Kernel.stubs(:exit)
      Kernel.stubs(:puts)
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@argv').must_equal([]) }
      it { instance.instance_variable_get('@stdin').must_equal(STDIN) }
      it { instance.instance_variable_get('@stdout').must_equal(STDOUT) }
      it { instance.instance_variable_get('@stderr').must_equal(STDERR) }
      it { instance.instance_variable_get('@kernel').must_equal(Kernel) }
      it { instance.instance_variable_get('@exit_code').must_equal(1) }
    end

    describe '#execute!' do
      subject { instance.execute! }

      it 'returns 0 for successful execution' do
        subject.must_equal(0)
      end

      # context 'when an exception is raised' do
      #   before do
      #     Application.stubs(:start).raises(StandardError)
      #   end

      #   it 'displays the exception' do
      #     capture_io do
      #       Launcher.execute!
      #     end.must_equal(["", ""])
      #   end
      # end
    end

  end # Launcher

end # Vedeu
