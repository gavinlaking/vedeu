require 'test_helper'

module Vedeu

  describe Output do

    let(:described) { Vedeu::Output }
    let(:instance)  { described.new(interface) }
    let(:interface) {
      Vedeu.interface 'flourine' do
        geometry do
          height 3
          width  32
        end
      end
    }
    let(:lines) {
      [
        Line.new({ streams: [Stream.new({ value: 'this is the first' })] }),
        Line.new({ streams: [Stream.new({ value: 'this is the second and it is long' })] }),
        Line.new({ streams: [Stream.new({ value: 'this is the third, it is even longer and still truncated' })] }),
        Line.new({ streams: [Stream.new({ value: 'this should not render' })] }),
      ]
    }

    before do
      interface.lines = lines
      IO.console.stubs(:print)
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@interface').must_equal(interface) }
    end

    describe '.render' do
      let(:rendered) { interface.render }

      before do
        Vedeu::FileRenderer.stubs(:render)
        Vedeu::HTMLRenderer.stubs(:to_file)
        Vedeu::TerminalRenderer.stubs(:render).returns(rendered)
      end

      subject { described.render(interface) }

      context 'when DRb is enabled' do
        it { }
      end

      # context 'when DRb is not enabled' do
      #   it 'sends the rendered interface to the Terminal' do
      #     Vedeu::TerminalRenderer.expects(:render)
      #     subject.must_be_instance_of(Array)
      #   end
      # end
    end

  end # Output

end # Vedeu
