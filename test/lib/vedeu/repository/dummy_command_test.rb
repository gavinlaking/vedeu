require_relative '../../../test_helper'

module Vedeu
  describe DummyCommand do
    let(:described_class) { DummyCommand }
    let(:subject)         { described_class.dispatch(command) }
    let(:command)         {}

    it { subject.must_be_instance_of(Symbol) }

    context 'when the value exists' do
      let(:command) { :test_command }

      it { subject.must_equal(:test_command) }
    end

    context 'when the value does not exist' do
      it { subject.must_equal(:dummy) }
    end
  end
end
