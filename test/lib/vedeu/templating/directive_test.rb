require 'test_helper'

module Vedeu

  module Templating

    describe Directive do

      let(:described) { Vedeu::Templating::Directive }
      let(:instance)  { described.new(code) }
      let(:code) {
        "colour(foreground: '#0f0') { 'Yay!' }"
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@code').must_equal(code) }
      end

      describe '.process' do
        it { described.must_respond_to(:process) }
      end

      describe '#process' do
        let(:colour)   { Vedeu::Colour.coerce(foreground: '#0f0') }
        let(:expected) { Vedeu::Stream.new(value: 'Yay!', colour: colour) }

        subject { instance.process }

        it { subject.must_be_instance_of(Vedeu::Stream) }
        it { subject.must_equal(expected) }
      end

    end # Directive

  end # Templating

end # Vedeu
