require 'test_helper'

module Vedeu

  describe Stream do

    let(:described) { Stream.new(value, parent, colour, style) }
    let(:value)     { 'Some text' }
    let(:parent)    { Line.new([], nil, Colour.new({ background: '#0000ff', foreground: '#ffff00' }), Style.new('normal')) }
    let(:colour)    { mock('Colour') }
    let(:style)     { mock('Style') }

    describe '#initialize' do
      it { described.must_be_instance_of(Stream) }
      it { assigns(described, '@value', value) }
      it { assigns(described, '@parent', parent) }
      it { assigns(described, '@colour', colour) }
      it { assigns(described, '@style', style) }
    end

    describe '#chars' do
      it { return_type_for(described.chars, Array) }

      context 'when there is content' do
        it 'returns a collection of strings containing escape sequences and ' \
           'content' do

          skip

          # described.chars.must_equal(
          #   [
          #     "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27mS\e[38;2;255;255;0m\e[48;2;0;0;255m",
          #     "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27mo\e[38;2;255;255;0m\e[48;2;0;0;255m",
          #     "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27mm\e[38;2;255;255;0m\e[48;2;0;0;255m",
          #     "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27me\e[38;2;255;255;0m\e[48;2;0;0;255m",
          #     "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27m \e[38;2;255;255;0m\e[48;2;0;0;255m",
          #     "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27mt\e[38;2;255;255;0m\e[48;2;0;0;255m",
          #     "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27me\e[38;2;255;255;0m\e[48;2;0;0;255m",
          #     "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27mx\e[38;2;255;255;0m\e[48;2;0;0;255m",
          #     "\e[38;2;255;0;0m\e[48;2;0;0;0m\e[24m\e[22m\e[27mt\e[38;2;255;255;0m\e[48;2;0;0;255m"
          #   ]
          # )
        end
      end

      context 'when there is no content' do
        let(:value) { '' }

        it 'returns an empty collection' do
          described.chars.must_equal([])
        end
      end
    end

    describe '#deputy' do
      it { return_type_for(described.deputy, DSL::Stream) }
    end

    describe '#empty?' do
      subject { described.empty? }

      context 'when there is no content' do
        let(:value) { '' }

        it { subject.must_equal(true) }
      end

      context 'when there is content' do
        it { subject.must_equal(false) }
      end
    end

    describe '#size' do
      subject { described.size }

      it { return_type_for(subject, Fixnum) }

      it 'returns the size of the stream' do
        subject.must_equal(9)
      end
    end

    describe '#to_s' do
      it { skip }
    end

  end # Stream

end # Vedeu
