require 'test_helper'

module Vedeu

  describe MainLoop do

    let(:described) { Vedeu::MainLoop }

    describe '.start!' do
      before do
        # subject.expects(:while).yields do
        #   String.expects(:new).returns("samantha")
        # end
      end

      subject { described.start! { } }

      # it { subject; described.instance_variable_get('@started').must_equal(true) }
      # it { subject; described.instance_variable_get('@loop').must_equal(true) }
    end

    describe '.stop!' do
      subject { described.stop! }

      it { subject; described.instance_variable_get('@loop').must_equal(false) }
    end

    describe '.safe_exit_point!' do
      subject { described.safe_exit_point! }

      context 'when we wish to continue' do
      end

      context 'when we wish to stop' do
        # it { proc { subject }.must_raise(VedeuInterrupt) }
      end
    end

  end # MainLoop

end # Vedeu
