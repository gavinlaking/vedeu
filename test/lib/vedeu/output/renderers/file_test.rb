require 'test_helper'

module Vedeu

  module Renderers

    describe File do

      let(:described) { Vedeu::Renderers::File }
      let(:instance)  { described.new(options) }
      let(:output)    { 'Some content...' }
      let(:options)   {
        {
          filename:    filename,
          timestamp:   timestamp,
          compression: compression,
        }
      }
      let(:filename)    { 'vedeu_renderers_file' }
      let(:timestamp)   { false }
      let(:compression) { false }

      before { ::File.stubs(:write) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#clear' do
        subject { instance.clear }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }
      end

      describe '#render' do
        let(:_time) { Time.new(2015, 4, 12, 20, 05, 00, "+01:00") }

        subject { instance.render(output) }

        # it { subject.must_be_instance_of(String) }

        context 'when the filename option is not set' do
          context 'when the timestamp option is not set' do
            # it {
            #   ::File.expects(:write).with('/tmp/out', nil)
            #   subject
            # }
          end

          context 'when the timestamp option is set' do
            let(:timestamp) { true }

            before { Time.stubs(:now).returns(_time) }

            # it {
            #   ::File.expects(:write).with('/tmp/out_1428865500.0', 'w')
            #   subject
            # }
          end
        end

        context 'when the filename option is set' do
          let(:filename) { 'some_name' }

          # it {
          #   ::File.expects(:write).with('/tmp/some_name', 'w')
          #   subject
          # }
        end
      end

    end # File

  end # Renderers

end # Vedeu
