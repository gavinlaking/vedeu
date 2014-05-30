require_relative '../../../test_helper'

module Vedeu
  describe EventLoop do
    let(:described_class) { EventLoop }

    describe '.start' do
      let(:subject) { described_class.start }

      it { subject.must_be_instance_of(NilClass) }
    end
  end
end
