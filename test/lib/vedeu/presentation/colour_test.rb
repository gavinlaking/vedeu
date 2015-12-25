# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Presentation

    describe Colour do

      let(:described)  { Vedeu::Presentation::Colour }
      let(:includer)   { Vedeu::PresentationColourTestClass.new(attributes) }
      let(:attributes) {
        {
          colour: colour,
          parent: parent
        }
      }
      let(:colour)     {
        {
          background: background,
          foreground: foreground
        }
      }
      let(:background) { '#000033' }
      let(:foreground) { '#aadd00' }
      let(:parent)     { Vedeu::ParentPresentationColourTestClass.new }

      describe '#colour' do
        subject { includer.colour }

        it { subject.must_be_instance_of(Vedeu::Colours::Colour) }

        context 'when a colour is not set' do
          let(:colour) {}

          context 'when a parent is not available' do
            let(:parent) {}

            it { subject.background.colour.must_equal('') }
            it { subject.foreground.colour.must_equal('') }
          end

          context 'when a parent is available' do
            it { subject.background.colour.must_equal('#330000') }
            it { subject.foreground.colour.must_equal('#00aadd') }
          end
        end

        context 'when a colour is set' do
          it { subject.background.colour.must_equal('#000033') }
          it { subject.foreground.colour.must_equal('#aadd00') }
        end
      end

      describe '#colour=' do
        let(:colour) {
          Vedeu::Colours::Colour.new(foreground: '#00ff00', background: '#000000')
        }

        subject { includer.colour=(colour) }

        it { subject.must_be_instance_of(Vedeu::Colours::Colour) }
      end

    end # Colour

  end # Presentation

end # Vedeu
