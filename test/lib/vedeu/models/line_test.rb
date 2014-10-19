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
    let(:streams) {
      [
        Stream.new({
          colour: { foreground: '#ff0000' }, text: 'Something interesting ' }),
        Stream.new({
          colour: { foreground: '#00ff00' }, text: 'on this line ' }),
        Stream.new({
          colour: { foreground: '#0000ff' }, text: 'would be cool, eh?' })
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

    describe '#chars' do
      it 'returns an Array' do
        line.chars.must_be_instance_of(Array)
      end

      context 'when there is no content' do
        before { line.stubs(:size).returns(0) }

        it { line.chars.must_equal([]) }
      end

      context 'when there is content' do
        it 'returns an Array' do
          line.chars.must_equal(
            [
              "\e[38;2;255;0;0mS", "\e[38;2;255;0;0mo", "\e[38;2;255;0;0mm",
              "\e[38;2;255;0;0me", "\e[38;2;255;0;0mt", "\e[38;2;255;0;0mh",
              "\e[38;2;255;0;0mi", "\e[38;2;255;0;0mn", "\e[38;2;255;0;0mg",
              "\e[38;2;255;0;0m ", "\e[38;2;255;0;0mi", "\e[38;2;255;0;0mn",
              "\e[38;2;255;0;0mt", "\e[38;2;255;0;0me", "\e[38;2;255;0;0mr",
              "\e[38;2;255;0;0me", "\e[38;2;255;0;0ms", "\e[38;2;255;0;0mt",
              "\e[38;2;255;0;0mi", "\e[38;2;255;0;0mn", "\e[38;2;255;0;0mg",
              "\e[38;2;255;0;0m ", "\e[38;2;0;255;0mo", "\e[38;2;0;255;0mn",
              "\e[38;2;0;255;0m ", "\e[38;2;0;255;0mt", "\e[38;2;0;255;0mh",
              "\e[38;2;0;255;0mi", "\e[38;2;0;255;0ms", "\e[38;2;0;255;0m ",
              "\e[38;2;0;255;0ml", "\e[38;2;0;255;0mi", "\e[38;2;0;255;0mn",
              "\e[38;2;0;255;0me", "\e[38;2;0;255;0m ", "\e[38;2;0;0;255mw",
              "\e[38;2;0;0;255mo", "\e[38;2;0;0;255mu", "\e[38;2;0;0;255ml",
              "\e[38;2;0;0;255md", "\e[38;2;0;0;255m ", "\e[38;2;0;0;255mb",
              "\e[38;2;0;0;255me", "\e[38;2;0;0;255m ", "\e[38;2;0;0;255mc",
              "\e[38;2;0;0;255mo", "\e[38;2;0;0;255mo", "\e[38;2;0;0;255ml",
              "\e[38;2;0;0;255m,", "\e[38;2;0;0;255m ", "\e[38;2;0;0;255me",
              "\e[38;2;0;0;255mh", "\e[38;2;0;0;255m?"
            ]
          )
        end
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

    describe '#method_missing' do
      it 'returns nil' do
        Line.new.some_missing_method(:test).must_equal(nil)
      end
    end

  end # Line

end # Vedeu
