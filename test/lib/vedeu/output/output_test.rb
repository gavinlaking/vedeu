require 'test_helper'

module Vedeu

  describe Output do

    let(:described) { Vedeu::Output }
    let(:instance)  { described.new(output) }
    let(:output)    {}
    let(:drb)       { false }

    before { Vedeu::Configuration.stubs(:drb?).returns(drb) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@output').must_equal(output) }
    end

    describe '.render' do
      before { Vedeu.renderers.stubs(:render) }

      subject { described.render(output) }

      context 'when DRb is enabled' do
        let(:drb)            { true }
        let(:virtual_buffer) { [] }

        before do
          # Vedeu::Renderers::HTML.stubs(:to_file)
          Vedeu::VirtualBuffer.stubs(:retrieve).returns(virtual_buffer)
        end

        it {
          Vedeu.expects(:trigger).with(:_drb_store_output_, output)
          subject
        }

        # it 'writes the virtual buffer to a file' do
        #   Vedeu::Renderers::HTML.expects(:to_file).with(virtual_buffer)
        #   subject
        # end
      end

      it { Vedeu.renderers.expects(:render).with(output); subject }
    end

  end # Output

end # Vedeu
