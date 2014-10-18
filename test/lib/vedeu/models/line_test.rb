require 'test_helper'

module Vedeu
  describe Line do
    let(:line)       { Line.new(attributes) }
    let(:attributes) {
      {
        colour: {
          foreground: '#ff0000',
          background: '#000000'
        },
        streams: streams,
        style:   'normal',
        parent:  nil,
      }
    }
    let(:streams) { # 53
      [
        # 22 (0,  21) (0, 21)
        Stream.new({
          colour: { foreground: '#ff0000' },
          text: 'Something interesting ' }),

        # 13 (22, 34) (0, 12)
        Stream.new({
          colour: { foreground: '#00ff00' },
          text: 'on this line ' }),

        # 18 (35, 53) (0, 17)
        Stream.new({
          colour: { foreground: '#0000ff' },
          text: 'would be cool, eh?' })
      ]
    }

    describe '#initialize' do
      it 'returns an instance of itself' do
        Line.new(attributes).must_be_instance_of(Line)
      end
    end

    describe '#attributes' do
      it 'returns the attributes' do
        line.attributes.must_equal(attributes)
      end
    end

    describe '#empty?' do
      context 'when there is no content' do
        before { line.stubs(:size).returns(0) }

        it { line.empty?.must_equal(true) }
      end

      it 'returns false when there is content' do
        line.empty?.must_equal(false)
      end
    end

    describe '#size' do
      it 'returns a Fixnum' do
        line.size.must_be_instance_of(Fixnum)
      end

      it 'returns the size of the line' do
        line.size.must_equal(53)
      end
    end

    describe '#streams' do
      it 'has a streams attribute' do
        line.streams.must_be_instance_of(Array)
      end
    end

    describe '#stream_offsets' do
      it 'returns the lengths of the streams' do
        line.stream_offsets.must_equal([22, 13, 18])
      end
    end

    describe '#to_s' do
      it 'returns a String' do
        line.to_s.must_equal(
          "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
          "\e[24m\e[22m\e[27m\e[38;2;255;0;0mSomething interesting "\
          "\e[38;2;0;255;0mon this line " \
          "\e[38;2;0;0;255mwould be cool, eh?"
        )
      end
    end
  end
end
