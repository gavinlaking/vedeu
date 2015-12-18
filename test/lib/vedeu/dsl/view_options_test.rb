require 'test_helper'

module Vedeu

  module DSL

    describe ViewOptions do

      let(:described) { Vedeu::DSL::ViewOptions }
      let(:instance)  { described.new(opts) }
      let(:opts)      {
        {
          align:    align,
          colour:   colour,
          name:     _name,
          pad:      pad,
          style:    style,
          truncate: truncate,
          width:    width,
          wordwrap: wordwrap,
        }
      }
      let(:align)    {}
      let(:colour)   {}
      let(:_name)    {}
      let(:pad)      {}
      let(:style)    {}
      let(:truncate) {}
      let(:width)    {}
      let(:wordwrap) {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }

        context 'when the opts are given' do
          it { instance.instance_variable_get('@_opts').must_equal(opts) }
        end

        context 'when the opts are not given' do
          let(:opts) {}
          let(:expected) {
            {
              align:    :none,
              colour:   nil,
              name:     nil,
              pad:      ' ',
              style:    nil,
              truncate: false,
              width:    nil,
              wordwrap: false,
            }
          }

          it { instance.instance_variable_get('@_opts').must_equal(expected) }
        end

        it { instance.instance_variable_get('@opts').must_equal(nil) }
      end

      describe '#align' do
        subject { instance.align }

        it { subject.must_be_instance_of(Vedeu::Coercers::Alignment) }

        context 'when there is no align option' do
          it { subject.value.must_equal(:none) }
        end

        context 'when there is an align option' do
          let(:align) { :center }

          it { subject.value.must_equal(:centre) }

          context 'when the align option is invalid' do
            let(:align) { :invalid }

            it { subject.value.must_equal(:none) }
          end
        end
      end

      describe '#colour' do
        subject { instance.colour }

        context 'when there are no colour options' do
          it { subject.must_equal(nil) }
        end

        context 'when there are colour options' do
          let(:colour) {
            {
              background: '#000088',
              foreground: '#ffff00',
            }
          }

          it {
            Vedeu::Colours::Colour.expects(:coerce).with(opts)
            subject
          }
          it { subject.must_be_instance_of(Vedeu::Colours::Colour) }
          it do
            subject.background.must_be_instance_of(Vedeu::Colours::Background)
          end
          it { subject.background.value.must_equal('#000088') }
          it do
            subject.foreground.must_be_instance_of(Vedeu::Colours::Foreground)
          end
          it { subject.foreground.value.must_equal('#ffff00') }
        end
      end

      describe '#name' do
        subject { instance.name }

        context 'when a name is given' do
          let(:_name) { :vedeu_dsl_view_options }

          it { subject.must_equal(_name) }
        end

        context 'when a name is not given' do
          it { subject.must_equal(nil) }
        end
      end

      describe '#options' do
        let(:expected) {
          {
            align:    Vedeu::Coercers::Alignment.new(:none),
            colour:   nil,
            name:     nil,
            pad:      ' ',
            style:    nil,
            truncate: false,
            width:    nil,
            wordwrap: false,
          }
        }

        subject { instance.options }

        it { subject.must_be_instance_of(Hash) }
        it { subject.must_equal(expected) }
      end

      describe '#pad' do
        subject { instance.pad }

        context 'when the pad option is nil' do
          let(:pad) {}

          it { subject.must_equal(' ') }
        end

        context 'when the pad option is not a string' do
          let(:pad) { 44 }

          it { subject.must_equal(' ') }
        end

        context 'when the pad is a multi-character string' do
          let(:pad) { 'multi' }

          it { subject.must_equal('m') }
        end
      end

      describe '#style' do
        subject { instance.style }

        context 'when there are no style options' do
          it { subject.must_equal(nil) }
        end

        context 'when there are style options' do
          let(:style) { [:bold, :underline] }

          it do
            Vedeu::Presentation::Style.expects(:coerce).with(opts)
            subject
          end
          it { subject.must_be_instance_of(Vedeu::Presentation::Style) }
          it { subject.value.must_equal(style) }
        end
      end

      describe '#truncate' do
        subject { instance.truncate }

        it { instance.must_respond_to(:truncate?) }

        context 'when the truncate option is true' do
          let(:truncate) { true }

          it { subject.must_equal(true) }
        end

        context 'when the truncate option is not given or false' do
          it { subject.must_equal(false) }
        end
      end

      describe '#width' do
        subject { instance.width }

        context 'when the width option is given' do
          let(:width) { 15 }

          it { subject.must_equal(width) }
        end

        context 'when the width option is not given' do
          context 'when the name option is given' do
            let(:_name)    { :vedeu_dsl_view_options }
            let(:geometry) {
              Vedeu::Geometries::Geometry.new(name: _name, width: 20)
            }

            before { Vedeu.geometries.stubs(:by_name).returns(geometry) }

            it { subject.must_equal(20) }
          end

          context 'when the name option is not given' do
            let(:_name) {}

            it { subject.must_equal(nil) }
          end
        end
      end

      describe '#wordwrap' do
        subject { instance.wordwrap }

        it { instance.must_respond_to(:wordwrap?) }

        context 'when the wordwrap option is true' do
          let(:wordwrap) { true }

          it { subject.must_equal(true) }
        end

        context 'when the wordwrap option is not given or false' do
          it { subject.must_equal(false) }
        end
      end

    end # ViewOptions

  end # DSL

end # Vedeu
