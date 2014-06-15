require_relative '../../../test_helper'

module Vedeu
  describe DummyCommand do
    let(:described_class) { DummyCommand }
    let(:subject)         { described_class.dispatch(command) }
    let(:command)         {}

    it 'returns a Symbol' do
      subject.must_be_instance_of(Symbol)
    end

    context 'when the value exists' do
      let(:command) { :test_command }

      it 'returns the value' do
        subject.must_equal(:test_command)
      end
    end

    context 'when the value does not exist' do
      it 'returns the default value' do
        subject.must_equal(:dummy)
      end
    end
  end
end
