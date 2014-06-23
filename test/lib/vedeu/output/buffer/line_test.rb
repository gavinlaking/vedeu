require_relative '../../../../test_helper'

module Vedeu
  module Buffer
    describe Line do
      let(:described_class)    { Line }
      let(:described_instance) { described_class.new(attributes) }
      let(:subject)            { described_instance }
      let(:attributes)         {
        {
          style:      'normal',
          foreground: :red,
          background: :black,
          stream:     []
        }
      }

      it 'returns a Line instance' do
        subject.must_be_instance_of(Line)
      end

      it 'has a style attribute' do
        subject.style.must_be_instance_of(Array)
      end

      it 'has a foreground attribute' do
        subject.foreground.must_be_instance_of(Symbol)
      end

      it 'has a background attribute' do
        subject.background.must_be_instance_of(Symbol)
      end

      it 'has a stream attribute' do
        subject.stream.must_be_instance_of(Array)
      end
    end
  end
end
