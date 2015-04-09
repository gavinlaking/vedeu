require 'test_helper'

module Vedeu

  describe Output do

    let(:described) { Vedeu::Output }
    let(:instance)  { described.new(content) }
    let(:content)   {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@content').must_equal(content) }
    end

    describe '.render' do
      let(:rendered) { interface.render }

      before do
        Vedeu.renderers.stubs(:render)
        # Vedeu::FileRenderer.stubs(:render)
        # Vedeu::HTMLRenderer.stubs(:to_file)
        # Vedeu::TerminalRenderer.stubs(:render).returns(rendered)
      end

      subject { described.render(content) }

      # context 'when DRb is enabled' do
      #   it { }
      # end

      # context 'when DRb is not enabled' do
      #   it 'sends the rendered interface to the Terminal' do
      #     Vedeu::TerminalRenderer.expects(:render)
      #     subject.must_be_instance_of(Array)
      #   end
      # end
    end

  end # Output

end # Vedeu
