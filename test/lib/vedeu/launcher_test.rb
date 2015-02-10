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
      it { described.must_be_instance_of(Launcher) }
      it { described.instance_variable_get('@argv').must_equal([]) }
      it { described.instance_variable_get('@stdin').must_equal(STDIN) }
      it { described.instance_variable_get('@stdout').must_equal(STDOUT) }
      it { described.instance_variable_get('@stderr').must_equal(STDERR) }
      it { described.instance_variable_get('@kernel').must_equal(Kernel) }
      it { described.instance_variable_get('@exit_code').must_equal(1) }
    end

    describe '#execute!' do
      it 'returns 0 for successful execution' do
        Launcher.new.execute!.must_equal(0)
      end

      # context 'when an exception is raised' do
      #   before do
      #     Application.stubs(:start).raises(StandardError)
      #   end

      #   it 'displays the exception' do
      #     capture_io do
      #       Launcher.new.execute!
      #     end.must_equal(["", ""])
      #   end
      # end
    end

  end # Launcher

end # Vedeu
