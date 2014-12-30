require 'test_helper'

module Vedeu

  module DSL

    describe Colour do
      let(:model) { Vedeu::Interface.new }
      let(:background) { '#00ff00' }
      let(:foreground) { '#ff00ff' }

      describe '#background' do
        subject { Vedeu::DSL::Interface.new(model).background(background) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, '#00ff00') }
      end

      describe '#foreground' do
        subject { Vedeu::DSL::Interface.new(model).foreground(foreground) }

        it { return_type_for(subject, String) }
        it { return_value_for(subject, '#ff00ff') }
      end

      describe '#colour' do
        let(:attributes) { { background: background, foreground: foreground } }

        subject { Vedeu::DSL::Interface.new(model).colour(attributes) }

        it { return_type_for(subject, Vedeu::Colour) }

        context 'with an invalid attribute' do
          let(:attributes) { { invalid: background, foreground: foreground } }

          it 'sets only the valid attributes' do
            subject.attributes.must_equal(
              { background: '', foreground: '#ff00ff' }
            )
          end
        end

        context 'with an empty value' do
          let(:attributes) { { background: background, foreground: '' } }

          it 'sets only the valid attributes' do
            subject.attributes.must_equal(
              { background: '#00ff00', foreground: '' }
            )
          end
        end
      end

    end # Colour

  end # DSL

end # Vedeu
