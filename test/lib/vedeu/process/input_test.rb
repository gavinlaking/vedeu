require_relative '../../../test_helper'

module Vedeu
  describe Input do
    let(:described_class) { Input }
    let(:input)           { "" }
    let(:subject)         { described_class.new }

    before { Terminal.stubs(:input).returns(input) }

    it { subject.must_be_instance_of(Input) }

    describe '.capture' do
      let(:subject) { described_class.capture }

      it { subject.must_be_instance_of(Array) }

      it { subject.wont_be_empty }
    end
  end
end
