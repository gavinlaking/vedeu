# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Renderers

    describe Text do

      let(:described) { Vedeu::Renderers::Text }
      let(:instance)  { described.new(options) }
      let(:options)   {
        {
          compression:   compression,
          end_tag:       end_tag,
          end_row_tag:   end_row_tag,
          filename:      filename,
          output:        'EMPTY',
          start_tag:     start_tag,
          start_row_tag: start_row_tag,
          template:      template,
          timestamp:     timestamp,
          write_file:    write_file,
        }
      }
      let(:compression)   { false }
      let(:end_tag)       { '</td>' }
      let(:end_row_tag)   { '</tr>' }
      let(:filename)      { 'vedeu_renderers_text' }
      let(:start_tag)     { '<td' }
      let(:start_row_tag) { '<tr>' }
      let(:template)      {
        ::File.dirname(__FILE__) + '/../../../support/templates/' \
        'html_renderer.vedeu'
      }
      let(:timestamp)     { false }
      let(:write_file)    { false }

      let(:geometry)  {
        Vedeu::Geometries::Geometry.new(name: 'Vedeu::Renderers::Text',
                                        x:    2,
                                        xn:   4,
                                        y:    2,
                                        yn:   4)
      }

      before { ::File.stubs(:write) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#clear' do
        subject { instance.clear }

        it { subject.must_equal('') }
      end

      describe '#render' do
        before do
          Vedeu.stubs(:height).returns(5)
          Vedeu.stubs(:width).returns(5)
          Vedeu.geometries.stubs(:by_name).returns(geometry)
          ::File.stubs(:write)
        end

        subject { instance.render(output) }

        context 'when the output is nil' do
          let(:output) {}

          it { subject.must_equal('') }
        end

        context 'when the output is a Vedeu::Models::Page' do
          let(:output) { Vedeu::Models::Page.coerce(rows) }
          let(:rows) {
            [
              Vedeu::Models::Row.new([
                Vedeu::Cells::TopLeft.new,
                Vedeu::Cells::TopHorizontal.new,
                Vedeu::Cells::TopRight.new,
              ]),
              Vedeu::Models::Row.new([
                Vedeu::Cells::LeftVertical.new,
                Vedeu::Cells::Char.new,
                Vedeu::Cells::RightVertical.new,
              ]),
              Vedeu::Models::Row.new([
                Vedeu::Cells::BottomLeft.new,
                Vedeu::Cells::BottomHorizontal.new,
                Vedeu::Cells::BottomRight.new,
              ]),
            ]
          }
          let(:expected) {
            "     \n" \
            " + + \n" \
            "     \n" \
            " + + \n" \
            "     "
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#write' do
        it { instance.must_respond_to(:write) }
      end

    end # Text

  end # Renderers

end # Vedeu
