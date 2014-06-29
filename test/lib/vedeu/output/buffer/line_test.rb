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

      describe '#initialize' do
        let(:subject) { described_instance }

        it 'returns a Line instance' do
          subject.must_be_instance_of(Line)
        end
      end

      describe '#style' do
        let(:subject) { described_instance.style }

        it 'has a style attribute' do
          subject.must_be_instance_of(Array)

          subject.must_equal([:normal])
        end
      end

      describe '#foreground' do
        let(:subject) { described_instance.foreground }

        it 'has a foreground attribute' do
          subject.must_be_instance_of(Symbol)

          subject.must_equal(:red)
        end
      end

      describe '#background' do
        let(:subject) { described_instance.background }

        it 'has a background attribute' do
          subject.must_be_instance_of(Symbol)

          subject.must_equal(:black)
        end
      end

      describe '#stream' do
        let(:subject) { described_instance.stream }

        it 'has a stream attribute' do
          subject.must_be_instance_of(Array)

          subject.must_equal([])
        end
      end

      describe '#to_compositor' do
        let(:subject) { described_instance.to_compositor }

        it 'returns an Array' do
          subject.must_be_instance_of(Array)

          subject.must_equal(
            [
              {
                style:  [:normal],
                colour: [:red, :black]
              }
            ]
          )
        end
      end
    end
  end
end
