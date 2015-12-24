require 'test_helper'

module Vedeu

  module Coercers

    describe ColourAttributes do

      let(:described) { Vedeu::Coercers::ColourAttributes }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.coerce' do
        subject { described.coerce(_value) }

        context 'when the value is a Hash' do
          context 'when the value is empty' do
            let(:_value) { {} }

            it { subject.must_equal({}) }
          end

          context 'when the value has a background key' do
            let(:_value)     { { background: background } }
            let(:background) { '#123456' }

            it { subject.must_equal(_value) }

            context 'but the background is invalid' do
              let(:background) { :invalid }

              it { subject.must_equal({}) }
            end
          end

          context 'when the value has a foreground key' do
            let(:_value)     { { foreground: foreground } }
            let(:foreground) { '#654321' }

            it { subject.must_equal(_value) }

            context 'but the foreground is invalid' do
              let(:foreground) { :invalid }

              it { subject.must_equal({}) }
            end
          end

          context 'when the value has both background and foreground keys' do
            let(:_value) {
              {
                background: background,
                foreground: foreground,
              }
            }
            let(:background) { '#123456' }
            let(:foreground) { '#654321' }

            it { subject.must_equal(_value) }

            context 'but the foreground is invalid' do
              let(:foreground) { :invalid }
              let(:expected)   { { background: background } }

              it { subject.must_equal(expected) }
            end

            context 'but the background is invalid' do
              let(:background) { :invalid }
              let(:expected)   { { foreground: foreground } }

              it { subject.must_equal(expected) }
            end
          end

          context 'when the value has a colour key' do
            let(:_value) { { colour: colour } }

            context 'but the colour is invalid' do
              let(:colour) { :invalid }

              it { subject.must_equal({}) }
            end

            context 'and the colour has a background key' do
              let(:_value)     { { colour: { background: background } } }
              let(:background) { '#7890ab' }
              let(:expected)   { { background: background } }

              it { subject.must_equal(expected) }

              context 'but the background is invalid' do
                let(:background) { :invalid }

                it { subject.must_equal({}) }
              end
            end

            context 'and the colour has a foreground key' do
              let(:_value)     { { colour: { foreground: foreground } } }
              let(:foreground) { '#ba0987' }
              let(:expected)   { { foreground: foreground } }

              it { subject.must_equal(expected) }

              context 'but the foreground is invalid' do
                let(:foreground) { :invalid }

                it { subject.must_equal({}) }
              end
            end

            context 'and the colour has both background and foreground keys' do
              let(:_value) {
                {
                  colour: {
                            background: background,
                            foreground: foreground,
                          }
                }
              }
              let(:background) { '#fed456' }
              let(:foreground) { '#654def' }
              let(:expected) {
                {
                  background: background,
                  foreground: foreground,
                }
              }

              it { subject.must_equal(expected) }

              context 'but the foreground is invalid' do
                let(:foreground) { :invalid }
                let(:expected)   { { background: background } }

                it { subject.must_equal(expected) }
              end

              context 'but the background is invalid' do
                let(:background) { :invalid }
                let(:expected)   { { foreground: foreground } }

                it { subject.must_equal(expected) }
              end
            end
          end
        end

        context 'when the value is not a Hash' do
          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

      describe '#coerce' do
        it { instance.must_respond_to(:coerce) }
      end

    end # ColourAttributes

  end # Coercers

end # Vedeu
