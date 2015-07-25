require 'test_helper'

module Vedeu

  module Templating

  	describe PostProcessor do

      let(:described) { Vedeu::Templating::PostProcessor }
      let(:instance)  { described.new(content) }
      let(:content)   {
        "Some text here\n" \
        "{{ colour(foreground: '#0f0') { 'Yay!' } }}\n" \
        "More text here\n"
      }
      let(:expected) {
        Vedeu::Streams.new([
          Vedeu::Stream.new(value: 'Some text here'),
          Vedeu::Stream.new(value: 'Yay!',
                            colour: Vedeu::Colour.coerce(foreground: '#0f0')),
          Vedeu::Stream.new(value: 'More text here')
        ])
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@content').must_equal(content) }
      end

      describe '.process' do
        subject { described.process(content) }

        # it { subject.must_equal(expected) }
      end

      describe '#process' do
        it { instance.must_respond_to(:process) }
      end

  	end # PostProcessor

  end # Templating

end # Vedeu
