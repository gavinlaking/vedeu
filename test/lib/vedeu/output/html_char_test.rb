require 'test_helper'

module Vedeu

  describe HTMLChar do

    let(:described)  { Vedeu::HTMLChar }
    let(:instance)   { described.new(char, options) }
    let(:char)       { Vedeu::Views::Char.new(attributes) }
    let(:options)    {
      {
        start_tag: '<td',
        end_tag:   '</td>',
      }
    }
    let(:attributes) {
      {
        border: border,
        colour: colour,
        parent: parent,
        value:  _value
      }
    }
    let(:border) {}
    let(:colour) {}
    let(:parent) { Vedeu::Views::Line.new(colour: parent_colour) }
    let(:parent_colour) {}
    let(:_value) {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@char').must_equal(char) }
      it { instance.instance_variable_get('@options').must_equal(options) }
    end

    describe '.render' do
      subject { described.render(char, options) }

      it { subject.must_be_instance_of(String) }

      context 'when there is a border' do
        let(:border) { :top_left }

        context 'when there is a colour' do
          let(:colour) {
            Vedeu::Colours::Colour.new(background: '#220022',
                                       foreground: '#aadd00')
          }

          it { subject.must_equal(
            "<td style='" \
            "border:1px #220022 solid;" \
            "background:#220022;" \
            "color:#aadd00;"      \
            "border-top:1px #aadd00 solid;" \
            "border-left:1px #aadd00 solid;" \
            "'>&nbsp;</td>"
          ) }
        end

        context 'when there is no colour' do
          context 'when there is a parent colour' do
            let(:parent_colour) {
              Vedeu::Colours::Colour.new(background: '#002222',
                                         foreground: '#dd2200')
            }

            it { subject.must_equal(
              "<td style='" \
              "border:1px #002222 solid;" \
              "background:#002222;" \
              "color:#dd2200;"      \
              "border-top:1px #dd2200 solid;" \
              "border-left:1px #dd2200 solid;" \
              "'>&nbsp;</td>"
            ) }
          end

          context 'when there is no parent colour' do
            it { subject.must_equal("<td style=''>&nbsp;</td>") }
          end
        end
      end

      context 'when there is no border' do
        context 'when there is no value' do
          it { subject.must_equal('<td>&nbsp;</td>') }
        end

        context 'when the value is empty' do
          let(:_value) { '' }

          it { subject.must_equal('<td>&nbsp;</td>') }
        end

        context 'when there is a value' do
          let(:_value) { 'a' }

          it { subject.must_equal("<td style=''>a</td>") }
        end
      end
    end

  end # HTMLChar

end # Vedeu
