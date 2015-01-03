require 'test_helper'

module Vedeu

  describe Line do

    let(:described) { Line.new(streams, parent, colour, style) }
    let(:streams)   { [] }
    # let(:streams) {
    #   Vedeu::Model::Streams.new([
    #     Stream.new('Something interesting ',
    #       mock('Line'),
    #       Colour.new({ foreground: '#ff0000' }),
    #       Style.new('normal')),
    #     Stream.new('on this line ',
    #       mock('Line'),
    #       Colour.new({ foreground: '#00ff00' }),
    #       Style.new('normal')),
    #     Stream.new('would be cool, eh?',
    #       mock('Line'),
    #       Colour.new({ foreground: '#0000ff' }),
    #       Style.new('normal'))
    #   ], nil, mock('Line'))
    # }

    let(:parent)    { mock('Interface') }
    let(:colour)    { Colour.new({ foreground: '#ff0000', background: '#000000' }) }
    let(:style)     { Style.new('normal') }

    before do
      parent.stubs(:colour)
      parent.stubs(:style)
    end


    describe '#initialize' do
      it { return_type_for(described, Line) }
      it { assigns(described, '@streams', streams) }
      it { assigns(described, '@parent', parent) }
      it { assigns(described, '@colour', colour) }
      it { assigns(described, '@style', style) }
    end

    describe '#chars' do
      it { skip; return_type_for(described.chars, Array) }

      # context 'when there is no content' do
      #   it { described.chars.must_equal([]) }
      # end

      # context 'when there is content' do
      #   it 'returns an Array' do
      #     described.chars.must_equal(
      #       [
      #         "\e[38;2;255;0;0mS", "\e[38;2;255;0;0mo", "\e[38;2;255;0;0mm",
      #         "\e[38;2;255;0;0me", "\e[38;2;255;0;0mt", "\e[38;2;255;0;0mh",
      #         "\e[38;2;255;0;0mi", "\e[38;2;255;0;0mn", "\e[38;2;255;0;0mg",
      #         "\e[38;2;255;0;0m ", "\e[38;2;255;0;0mi", "\e[38;2;255;0;0mn",
      #         "\e[38;2;255;0;0mt", "\e[38;2;255;0;0me", "\e[38;2;255;0;0mr",
      #         "\e[38;2;255;0;0me", "\e[38;2;255;0;0ms", "\e[38;2;255;0;0mt",
      #         "\e[38;2;255;0;0mi", "\e[38;2;255;0;0mn", "\e[38;2;255;0;0mg",
      #         "\e[38;2;255;0;0m ", "\e[38;2;0;255;0mo", "\e[38;2;0;255;0mn",
      #         "\e[38;2;0;255;0m ", "\e[38;2;0;255;0mt", "\e[38;2;0;255;0mh",
      #         "\e[38;2;0;255;0mi", "\e[38;2;0;255;0ms", "\e[38;2;0;255;0m ",
      #         "\e[38;2;0;255;0ml", "\e[38;2;0;255;0mi", "\e[38;2;0;255;0mn",
      #         "\e[38;2;0;255;0me", "\e[38;2;0;255;0m ", "\e[38;2;0;0;255mw",
      #         "\e[38;2;0;0;255mo", "\e[38;2;0;0;255mu", "\e[38;2;0;0;255ml",
      #         "\e[38;2;0;0;255md", "\e[38;2;0;0;255m ", "\e[38;2;0;0;255mb",
      #         "\e[38;2;0;0;255me", "\e[38;2;0;0;255m ", "\e[38;2;0;0;255mc",
      #         "\e[38;2;0;0;255mo", "\e[38;2;0;0;255mo", "\e[38;2;0;0;255ml",
      #         "\e[38;2;0;0;255m,", "\e[38;2;0;0;255m ", "\e[38;2;0;0;255me",
      #         "\e[38;2;0;0;255mh", "\e[38;2;0;0;255m?"
      #       ]
      #     )
      #   end
      # end
    end

    describe '#deputy' do
      it { return_type_for(described.deputy, DSL::Line) }
    end

    describe '#empty?' do
      subject { described.empty? }

      context 'when there is no content' do
        let(:streams) { [] }

        it { return_type_for(subject, TrueClass) }
      end

      context 'when there is content' do
        it { return_type_for(subject, FalseClass) }
      end
    end

    describe '#size' do
      subject { described.size }

      it { return_type_for(subject, Fixnum) }

      it 'returns the size of the line' do
        subject.must_equal(53)
      end
    end

    describe '#streams' do
      subject { described.streams }

      it { return_type_for(subject, Vedeu::Model::Streams) }
    end

    describe '#to_s' do
      subject { described.to_s }

      it { return_type_for(subject, String) }

      it 'returns the line complete with formatting' do
        subject.must_equal(
          "\e[38;2;255;0;0m\e[48;2;0;0;0m" \
          "\e[24m\e[22m\e[27m\e[38;2;255;0;0mSomething interesting "\
          "\e[38;2;0;255;0mon this line " \
          "\e[38;2;0;0;255mwould be cool, eh?"
        )
      end
    end

  end # Line

end # Vedeu
