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
        subject.must_be_instance_of(String)
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

    describe '#to_json' do
      let(:subject) { described_instance.to_json }

      it 'returns an String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an String' do
        subject.must_equal("{\"colour\":{\"foreground\":\"\\u001b[38;5;196m\",\"background\":\"\\u001b[48;5;16m\"},\"style\":\"\\u001b[24m\\u001b[21m\\u001b[27m\",\"streams\":[]}")
      end
    end

    describe '#to_s' do
      let(:subject) { described_instance.to_s }

      it 'returns an String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an String' do
        subject.must_equal("\e[38;5;196m\e[48;5;16m\e[24m\e[21m\e[27m")
      end
    end
  end
end

