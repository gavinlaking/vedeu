# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Renderers

    describe JSON do

      let(:described) { Vedeu::Renderers::JSON }
      let(:instance)  { described.new(options) }
      let(:options)   {
        {
          compression:   compression,
          end_tag:       end_tag,
          end_row_tag:   end_row_tag,
          filename:      filename,
          output:        output,
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
      let(:filename)      { 'vedeu_renderers_json' }
      let(:start_tag)     { '<td' }
      let(:start_row_tag) { '<tr>' }
      let(:template)      {
        ::File.dirname(__FILE__) + '/../../../support/templates/' \
        'html_renderer.vedeu'
      }
      let(:timestamp)     { false }
      let(:write_file)    { false }
      let(:output) {
        Vedeu::Models::Page.coerce([
          Vedeu::Cells::Char.new(output_attributes)
        ])
      }
      let(:output_attributes) {
        {
          colour: {
            background: '#ff0000',
            foreground: '#ffffff',
          },
          name:     'Vedeu::Renderers::JSON',
          position: [2, 9],
          value:    'a',
        }
      }
      let(:output_as_hash) {
        [
          {
            name:     'Vedeu::Renderers::JSON',
            style:    '',
            type:     'char',
            value:    'a',
            colour:   {
              background: '#ff0000',
              foreground: '#ffffff',
            },
            position: {
              y: 2,
              x: 9,
            },
          }, {
            type:     :escape,
            value:    "\e[0m",
          }
        ]
      }
      let(:output_as_json) { ::JSON.pretty_generate(output_as_hash) }

      before { ::File.stubs(:write) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#clear' do
        subject { instance.clear }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal("{\n}") }
      end

      describe '#write' do
        subject { instance.write }

        context 'when the :write_file option is true' do
          let(:write_file) { true }

          it do
            ::File.expects(:write).with(filename, output_as_json)
            subject
          end
        end

        context 'when the :write_file option is false' do
          it { subject.must_equal(output_as_json) }
        end
      end

    end # JSON

  end # Renderers

end # Vedeu
