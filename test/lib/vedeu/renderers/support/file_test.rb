# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Renderers

    describe File do

      let(:described) { Vedeu::Renderers::File }
      let(:instance)  { described.new(options) }
      let(:output)    { 'Some content...' }
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
      let(:filename)      { 'vedeu_renderers_file' }
      let(:start_tag)     { '<td' }
      let(:start_row_tag) { '<tr>' }
      let(:template)      {
        ::File.dirname(__FILE__) + '/../../../support/templates/' \
        'html_renderer.vedeu'
      }
      let(:timestamp)     { false }
      let(:write_file)    { false }

      before { ::File.stubs(:write) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      # describe '#render' do
      #   let(:_time) { Time.new(2015, 4, 12, 20, 05, 00, "+01:00") }

      #   subject { instance.render(output) }

      #   # it { subject.must_be_instance_of(String) }

      #   context 'when the filename option is not set' do
      #     context 'when the timestamp option is not set' do
      #       # it do
      #       #   ::File.expects(:write).with(Dir.tmpdir + '/out', nil)
      #       #   subject
      #       # end
      #     end

      #     context 'when the timestamp option is set' do
      #       let(:timestamp) { true }

      #       before { Time.stubs(:now).returns(_time) }

      #       # it do
      #       #   ::File.expects(:write).with(Dir.tmpdir + '/out_1428865500.0', 'w')
      #       #   subject
      #       # end
      #     end
      #   end

      #   context 'when the filename option is set' do
      #     let(:filename) { 'some_name' }

      #     # it do
      #     #   ::File.expects(:write).with(Dir.tmpdir + '/some_name', 'w')
      #     #   subject
      #     # end
      #   end
      # end

      describe '#clear' do
        subject { instance.clear }

        it { subject.must_equal('') }
      end

      describe '#write' do
        subject { instance.write }

        it do
          ::File.expects(:write).with(filename, output)
          subject
        end

        it { subject.must_equal(output) }
      end

    end # File

  end # Renderers

end # Vedeu
