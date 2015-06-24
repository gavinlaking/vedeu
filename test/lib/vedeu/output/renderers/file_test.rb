require 'test_helper'

module Vedeu

  module Renderers

    describe File do

      let(:described) { Vedeu::Renderers::File }
      let(:instance)  { described.new(output, options) }
      let(:output)    {}
      let(:options)   {
        {
          timestamp: timestamp
        }
      }
      let(:timestamp) { true }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@output').must_equal(output) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '.render' do
        let(:_time) { Time.new(2015, 4, 12, 20, 05) }

        before { File.stubs(:open) }

        subject { described.render(output, options) }

        it { subject.must_be_instance_of(String) }

        # it { skip }
        # context 'when the timestamp option is true' do
        #   before { Time.stubs(:now).returns(_time) }

        #   it { File.expects(:open).with('/tmp/out_1428865500.0', 'w'); subject }
        # end

        # context 'when the timestamp option is false' do
        #   let(:timestamp) { false }

        #   it { File.expects(:open).with('/tmp/out', 'w'); subject }
        # end
      end

    end # File

  end # Renderers

end # Vedeu
