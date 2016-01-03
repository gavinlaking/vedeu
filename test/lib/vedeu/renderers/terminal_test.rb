# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Renderers

    describe Terminal do

      let(:described) { Vedeu::Renderers::Terminal }
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
      let(:filename)      { 'vedeu_renderers_terminal' }
      let(:start_tag)     { '<td' }
      let(:start_row_tag) { '<tr>' }
      let(:template)      {
        ::File.dirname(__FILE__) + '/../../../support/templates/' \
        'html_renderer.vedeu'
      }
      let(:timestamp)     { false }
      let(:write_file)    { false }

      let(:_name)     {}
      let(:output)    {
        Vedeu::Models::Page.coerce([
          [
            Vedeu::Cells::Empty.new(position: [1, 1]),
            Vedeu::Cells::Char.new(name: _name, value: 'a', position: [1, 2]),
            Vedeu::Cells::Empty.new(position: [1, 3]),
          ], [
            Vedeu::Cells::Empty.new(position: [2, 1]),
            Vedeu::Cells::Char.new(name: _name, value: 'b', position: [2, 2]),
            Vedeu::Cells::Empty.new(position: [2, 3]),
          ], [
            Vedeu::Cells::Empty.new(position: [3, 1]),
            Vedeu::Cells::Char.new(name: _name, value: 'c', position: [3, 2]),
            Vedeu::Cells::Empty.new(position: [3, 3]),
          ],
        ])
      }

      before do
        Vedeu::Terminal.stubs(:output).returns(output)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#clear' do
        before { Vedeu::Terminal.stubs(:clear) }

        subject { instance.clear }

        it do
          Vedeu::Terminal.expects(:clear)
          subject
        end
      end

      describe '#render' do
        subject { instance.render(output) }

        it { subject.must_be_instance_of(Vedeu::Models::Page) }
      end

      describe '#write' do
        it { instance.must_respond_to(:write) }
      end

    end # Terminal

  end # Renderers

end # Vedeu
