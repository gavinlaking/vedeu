require_relative '../../../test_helper'

module Vedeu
  describe Input do
    let(:described_class) { Input }
    let(:input)           { "" }

    before { Terminal.stubs(:input).returns(input) }

    describe '.capture' do
      let(:subject) { described_class.capture }

      it { subject.must_be_instance_of(String) }
    end
  end
end
