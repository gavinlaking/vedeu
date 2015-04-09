require 'test_helper'

module Vedeu

  module DSL

    describe Colour do

      let(:described)  { Vedeu::DSL::Colour }
      let(:dsl_klass)  { Vedeu::DSL::Interface.new(model) }
      let(:model)      { Vedeu::Interface.new }
      let(:background) { '#00ff00' }
      let(:foreground) { '#ff00ff' }

      describe 'alias methods' do
        it { dsl_klass.must_respond_to(:bg) }
        it { dsl_klass.must_respond_to(:bgcolor) }
        it { dsl_klass.must_respond_to(:fg) }
        it { dsl_klass.must_respond_to(:fgcolor) }
      end

      describe '#background' do
        subject { dsl_klass.background(background) }

        it { subject.must_be_instance_of(Vedeu::Colour) }

        it 'sets the background' do
          subject.attributes.must_equal(
            background: '#00ff00', foreground: ''
          )
        end
      end

      describe '#foreground' do
        subject { dsl_klass.foreground(foreground) }

        it { subject.must_be_instance_of(Vedeu::Colour) }

        it 'sets the foreground' do
          subject.attributes.must_equal(
            background: '', foreground: '#ff00ff'
          )
        end
      end

      describe '#colour' do
        let(:attributes) { { background: background, foreground: foreground } }

        subject { dsl_klass.colour(attributes) }

        it { subject.must_be_instance_of(Vedeu::Colour) }

        context 'with an invalid attribute' do
          let(:attributes) { { invalid: background, foreground: foreground } }

          it 'sets only the valid attributes' do
            subject.attributes.must_equal(
              background: '', foreground: '#ff00ff'
            )
          end
        end

        context 'with an empty value' do
          let(:attributes) { { background: background, foreground: '' } }

          it 'sets only the valid attributes' do
            subject.attributes.must_equal(
              background: '#00ff00', foreground: ''
            )
          end
        end
      end

    end # Colour

  end # DSL

end # Vedeu
