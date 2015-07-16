require 'test_helper'

module Vedeu

  module Templating

    describe Preprocessor do

      let(:described) { Vedeu::Templating::Preprocessor }
      let(:instance)  { described.new(lines) }
      let(:lines)     {
        [
          "Some text here\n",
          "{{ colour(foreground: '#0f0') { 'Yay!' } }}\n",
          "More text here\n"
        ]
      }
      let(:expected) {
        [
          Vedeu::Stream.new(value: 'Some text here'),
          Vedeu::Stream.new(value: 'Yay!',
                            colour: Vedeu::Colour.coerce(foreground: '#0f0')),
          Vedeu::Stream.new(value: 'More text here')
        ]
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@lines').must_equal(lines) }
      end

      describe '.process' do
        subject { described.process(lines) }

        it { subject.must_equal(expected) }
      end

      describe '#process' do
        subject { instance.process }

        it { subject.must_equal(expected) }
      end

    end # Preprocessor

  end # Templating

end # Vedeu
