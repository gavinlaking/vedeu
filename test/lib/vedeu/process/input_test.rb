require_relative '../../../test_helper'

module Vedeu
  describe Input do
    let(:described_class) { Input }
    let(:input)           { "" }
    let(:args)            { [] }

    before do
      CommandRepository.stubs(:find_by_input)
    end

    describe '.evaluate' do
      let(:subject) { described_class.evaluate(input, args) }

      it { subject.must_be_instance_of(NilClass) }
    end
  end
end
