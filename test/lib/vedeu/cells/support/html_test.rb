require 'test_helper'

module Vedeu

  module Cells

    describe HTML do

      let(:described) { Vedeu::Cells::HTML }
      let(:instance)  { described.new(cell, options) }
      let(:cell)      {
        Vedeu::Cells::Char.new(colour: {
                                 background: background,
                                 foreground: foreground,
                               },
                               value: _value)
      }
      let(:options)   {
        {
          start_tag: start_tag,
          end_tag:   end_tag,
        }
      }
      let(:start_tag)  { '<td' }
      let(:end_tag)    { '</td>' }
      let(:background) { '#220022' }
      let(:foreground) { '#0066ff' }
      let(:_value)     { 'A' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@cell').must_equal(cell) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#to_html' do
        subject { instance.to_html }

        it { subject.must_be_instance_of(String) }

        context 'with a custom :start_tag and :end_tag' do
          let(:start_tag) { '<div' }
          let(:end_tag)   { '</div>' }
          let(:expected)  {
            "<div style='background-color:#220022;color:#0066ff;'>A</div>"
          }

          it { subject.must_equal(expected) }
        end

        context 'with the default :start_tag and :end_tag' do
          let(:expected)  {
            "<td style='background-color:#220022;color:#0066ff;'>A</td>"
          }

          it { subject.must_equal(expected) }
        end

        context 'when the cell has only a background colour' do
          let(:foreground) {}
          let(:expected)  {
            "<td style='background-color:#220022;'>A</td>"
          }

          it { subject.must_equal(expected) }
        end

        context 'when the cell has only a foreground colour' do
          let(:background) {}
          let(:expected)  {
            "<td style='color:#0066ff;'>A</td>"
          }

          it { subject.must_equal(expected) }
        end

        context 'when the cell has neither background or foreground colours' do
          let(:background) {}
          let(:foreground) {}
          let(:expected)   { '<td>A</td>' }

          it { subject.must_equal(expected) }
        end

        context 'when the cell does not have a value or does not respond to ' \
                ':as_html' do
          let(:_value)   { '' }
          let(:expected) {
            "<td style='background-color:#220022;color:#0066ff;'>&nbsp;</td>"
          }

          it { subject.must_equal(expected) }
        end
      end

    end # HTML

  end # Cells

end # Vedeu
