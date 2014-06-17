require_relative '../../../test_helper'

module Vedeu
  describe Input do
    let(:described_class) { Input }
    let(:input)           { "" }
    let(:subject)         { described_class.new }

    before { Terminal.stubs(:input).returns(input) }

    it 'return an Input instance' do
      subject.must_be_instance_of(Input)
    end

    describe '.capture' do
      let(:subject) { described_class.capture }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns the entered characters' do
        subject.wont_be_empty
      end
    end
  end
end
