require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/models/line'

module Vedeu
  describe Line do
    let(:described_class)    { Line }
    let(:described_instance) { described_class.new(attributes) }
    let(:subject)            { described_instance }
    let(:attributes)         {
      {
        style:  'normal',
        colour: { foreground: '#ff0000', background: '#000000' },
        stream: []
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
        subject.must_be_instance_of(Style)
      end
    end

    describe '#colour' do
      let(:subject) { described_instance.colour }

      it 'has a colour attribute' do
        subject.must_be_instance_of(Colour)
      end
    end

    describe '#streams' do
      let(:subject) { described_instance.streams }

      it 'has a streams attribute' do
        subject.must_be_instance_of(Array)

        subject.must_equal([])
      end
    end

    # describe '#to_compositor' do
    #   let(:subject) { described_instance.to_compositor }

    #   it 'returns an Array' do
    #     subject.must_be_instance_of(Array)

    #     subject.must_equal(
    #       [
    #         {
    #           style:  ['normal'],
    #           colour: { foreground: '#ff0000', background: '#000000' }
    #         }
    #       ]
    #     )
    #   end
    # end
  end
end

