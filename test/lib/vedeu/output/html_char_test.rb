require 'test_helper'

module Vedeu

  describe HTMLChar do

    let(:described)  { Vedeu::HTMLChar }
    let(:instance)   { described.new(char) }
    let(:char)       { Vedeu::Char.new(attributes) }
    let(:attributes) {
      {
        border: border,
        colour: colour,
        parent: parent,
        value:  value
      }
    }
    let(:border) {}
    let(:colour) {}
    let(:parent) { Vedeu::Line.new(colour: parent_colour) }
    let(:parent_colour) {}
    let(:value) {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::HTMLChar) }
      it { instance.instance_variable_get('@char').must_equal(char) }
    end

    describe '.render' do
      subject { described.render(char) }

      it { subject.must_be_instance_of(String) }

      context 'when there is a border' do
        let(:border) { :top_left }

        context 'when there is a colour' do
          let(:colour) { Vedeu::Colour.new(background: '#220022', foreground: '#aadd00') }

          it { subject.must_equal(
            "<td style='background:#220022;color:#aadd00;border:1px #220022 solid;border-top:1px #aadd00 solid;border-left:1px #aadd00 solid;'>&nbsp;</td>"
          ) }
        end

        context 'when there is no colour' do
          context 'when there is a parent colour' do
            let(:parent_colour) { Vedeu::Colour.new(background: '#002222', foreground: '#dd2200') }

            it { subject.must_equal(
              "<td style='background:#002222;color:#dd2200;border:1px #002222 solid;border-top:1px #dd2200 solid;border-left:1px #dd2200 solid;'>&nbsp;</td>"
            ) }
          end

          context 'when there is no parent colour' do
            it { subject.must_equal(
              "<td style='background:#000;color:#222;border:1px #000 solid;border-top:1px #222 solid;border-left:1px #222 solid;'>&nbsp;</td>"
            ) }
          end
        end
      end

      {
        top_horizontal:    "border-top:1px #222 solid;",
        left_vertical:     "border-left:1px #222 solid;",
        right_vertical:    "border-right:1px #222 solid;",
        bottom_horizontal: "border-bottom:1px #222 solid;",
        top_left:          "border-top:1px #222 solid;border-left:1px #222 solid;",
        top_right:         "border-top:1px #222 solid;border-right:1px #222 solid;",
        bottom_left:       "border-bottom:1px #222 solid;border-left:1px #222 solid;",
        bottom_right:      "border-bottom:1px #222 solid;border-right:1px #222 solid;",
        horizontal:        '',
        vertical:          ''
      }.each do |border_style, result|
        context "when there is a border (#{border_style.inspect})" do
          let(:border) { border_style }

          it { subject.must_equal(
            "<td style='background:#000;color:#222;border:1px #000 solid;" +
            result +
            "'>&nbsp;</td>"
          ) }
        end
      end

      context 'when there is no border' do
        context 'when there is no value' do
          it { subject.must_equal("<td>&nbsp;</td>") }
        end

        context 'when the value is empty' do
          let(:value) { '' }

          it { subject.must_equal("<td>&nbsp;</td>") }
        end

        context 'when there is a value' do
          let(:value) { 'a' }

          it { subject.must_equal(
            "<td style='background:#000;color:#222;border:1px #000 solid;'>a</td>"
          ) }
        end
      end
    end

  end # HTMLChar

end # Vedeu
