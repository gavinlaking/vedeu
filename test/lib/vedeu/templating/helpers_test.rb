require 'test_helper'

module Vedeu

  module Templating

    class HelpersTestClass

      include Vedeu::Templating::Helpers

    end

    describe Helpers do

      let(:described) { Vedeu::Templating::Helpers }
      let(:instance)  { Vedeu::Templating::HelpersTestClass.new }

      describe '#background' do
        let(:expected) {
          Vedeu::Stream.new(value: 'background text',
                            colour: Vedeu::Colour.coerce(background: '#000000'))
        }

        subject { instance.background('#000000') { 'background text' } }

        it { instance.must_respond_to(:bg) }

        it { subject.must_equal(expected) }
      end

      describe '#colour' do
        let(:attributes) { {} }

        subject { instance.colour(attributes) { 'colour text' } }

        context 'with no attributes' do
          it { subject.must_be_instance_of(Vedeu::Stream) }
        end

        context 'with a background attribute' do
          let(:attributes) {
            {
              background: '#002200'
            }
          }
          let(:expected) {
            Vedeu::Stream.new(value: 'colour text',
                              colour: Vedeu::Colour.coerce(attributes))
          }

          it { subject.must_equal(expected) }
        end

        context 'with a foreground attribute' do
          let(:attributes) {
            {
              foreground: '#ff0000'
            }
          }
          let(:expected) {
            Vedeu::Stream.new(value: 'colour text',
                              colour: Vedeu::Colour.coerce(attributes))
          }

          it { subject.must_equal(expected) }
        end

        context 'with both attributes' do
          let(:attributes) {
            {
              background: '#000022',
              foreground: '#ff7700',
            }
          }
          let(:expected) {
            Vedeu::Stream.new(value: 'colour text',
                              colour: Vedeu::Colour.coerce(attributes))
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#foreground' do
        let(:expected) {
          Vedeu::Stream.new(value: 'foreground text',
                            colour: Vedeu::Colour.coerce(foreground: '#000000'))
        }

        subject { instance.foreground('#000000') { 'foreground text' } }

        it { instance.must_respond_to(:fg) }

        it { subject.must_equal(expected) }
      end

    end # Helpers

  end # Templating

end # Vedeu
