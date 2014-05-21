require_relative '../../../test_helper'

module Vedeu
  describe Exit do
    let(:described_class) { Exit }

    describe '.dispatch' do
      subject { described_class.dispatch }

      it { subject.must_be_instance_of(Symbol) }

      it { subject.must_equal(:stop) }
    end
  end
end
