require 'test_helper'

module Vedeu

  describe MainLoop do

    let(:described) { Vedeu::MainLoop }

    describe '.start!' do
      before do
      end

      subject { described.start! { } }
    end

    describe '.stop!' do
      subject { described.stop! }

      it { subject; described.instance_variable_get('@loop').must_equal(false) }
    end

  end # MainLoop

end # Vedeu
