require_relative '../../../test_helper'

module Vedeu
  describe Input do
    let(:described_class) { Input }
    let(:input)           { "" }

    before do
      Terminal.stubs(:input).returns(input)
      CommandRepository.stubs(:find_by_input)
    end

    describe '.evaluate' do
      let(:subject) { described_class.evaluate }

      it { subject.must_be_instance_of(NilClass) }

      context 'when the result is :stop' do
        let(:input) {}
      end

      context 'when the result is empty' do
        let(:input) {}
      end
    end
  end
end
