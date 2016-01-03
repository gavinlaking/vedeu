# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Renderers

    class RenderersTestClass

      include Vedeu::Renderers::Options

    end # RenderersTestClass

    describe Options do

      let(:described) { Vedeu::Renderers::Options }
      let(:instance)  {}

      let(:including_described) { Vedeu::Renderers::RenderersTestClass }
      let(:including_instance)  { including_described.new(options) }
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
      let(:filename)      { 'vedeu_renderers_options' }
      let(:start_tag)     { '<td' }
      let(:start_row_tag) { '<tr>' }
      let(:template)      {
        ::File.dirname(__FILE__) + '/../../../support/templates/' \
        'html_renderer.vedeu'
      }
      let(:timestamp)     { false }
      let(:write_file)    { false }

      describe '#initialize' do
        it { including_instance.must_be_instance_of(including_described) }
        it { including_instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#clear' do
        subject { including_instance.clear }

        it { proc { subject }.must_raise(Vedeu::Error::NotImplemented) }
      end

      describe '#options' do
        it { including_instance.must_respond_to(:options) }
      end

      describe '#options=' do
        it { including_instance.must_respond_to(:options=) }
      end

      describe '#render' do
        subject { including_instance.render }

        it { proc { subject }.must_raise(Vedeu::Error::NotImplemented) }
      end

      describe '#write' do
        subject { including_instance.write }

        it { proc { subject }.must_raise(Vedeu::Error::NotImplemented) }
      end

      # describe '#compression?' do
      #   subject { including_instance.compression? }

      #   context 'when the option is not set or is set to false' do
      #     before { options.tap { |o| o.delete(:compression) } }

      #     context 'when Vedeu.config.compression? is set to false' do
      #       before { Vedeu.config.stubs(:compression?).returns(false) }

      #       it { subject.must_equal(false) }
      #     end

      #     context 'when Vedeu.config.compression? is set to true' do
      #       before { Vedeu.config.stubs(:compression?).returns(true) }

      #       it { subject.must_equal(true) }
      #     end
      #   end

      #   context 'when the option is set and is true' do
      #     let(:compression) { true }

      #     it { subject.must_equal(true) }
      #   end
      # end

      # @todo Add more tests.
      # it { skip }

    end # Options

  end # Renderers

end # Vedeu
