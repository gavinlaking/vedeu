require 'test_helper'

module Vedeu

  module DSL

    describe Presentation do

      let(:described)  { Vedeu::DSL::Presentation }
      let(:instance)   { Vedeu::DSL::Interface.new(model) }
      let(:model)      { Vedeu::Interface.new }
      let(:background) { '#00ff00' }
      let(:foreground) { '#ff00ff' }

      describe '#background' do
        subject { instance.background(background) }

        it { instance.must_respond_to(:bg) }
        it { instance.must_respond_to(:bgcolor) }

        it { subject.must_be_instance_of(Vedeu::Colour) }

        it 'sets the background' do
          subject.attributes.must_equal(
            background: '#00ff00', foreground: ''
          )
        end
      end

      describe '#foreground' do
        subject { instance.foreground(foreground) }

        it { instance.must_respond_to(:fg) }
        it { instance.must_respond_to(:fgcolor) }

        it { subject.must_be_instance_of(Vedeu::Colour) }

        it 'sets the foreground' do
          subject.attributes.must_equal(
            background: '', foreground: '#ff00ff'
          )
        end
      end

      describe '#colour' do
        let(:attributes) { { background: background, foreground: foreground } }

        subject { instance.colour(attributes) }

        it { subject.must_be_instance_of(Vedeu::Colour) }

        context 'with an empty value' do
          let(:attributes) { { background: background, foreground: '' } }

          it 'sets only the valid attributes' do
            subject.attributes.must_equal(
              background: '#00ff00', foreground: ''
            )
          end
        end
      end

      describe '#style' do
        let(:args)  { :bold }

        subject { instance.style(args) }

        it { instance.must_respond_to(:styles) }

        it { subject.must_be_instance_of(Vedeu::Style) }
      end

    end # Presentation

  end # DSL

end # Vedeu
