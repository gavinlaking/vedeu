require 'test_helper'

module Vedeu

  module Output

    describe Output do

      let(:described) { Vedeu::Output::Output }
      let(:instance)  { described.new(output) }
      let(:output)    {}
      let(:drb)       { false }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@output').must_equal(output) }
      end

      describe '.render' do
        # let(:buffer) { mock }

        # before do
        #   Vedeu::Terminal::Buffer.stubs(:write).returns(buffer)
        #   buffer.stubs(:render)
        # end

        # subject { described.render(output) }

        # it {
        #   Vedeu::Terminal::Buffer.expects(:write).with(output)
        #   subject
        # }

        # it {
        #   buffer.expects(:render)
        #   subject
        # }
      end

      describe '#render' do
        it { instance.must_respond_to(:render) }
      end

    end # Output

  end # Output

end # Vedeu
