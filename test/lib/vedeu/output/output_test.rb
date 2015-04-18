require 'test_helper'

module Vedeu

  describe Output do

    let(:described) { Vedeu::Output }
    let(:instance)  { described.new(content) }
    let(:content)   {}
    let(:drb)       { false }

    before do
      Vedeu::Configuration.stubs(:drb?).returns(drb)
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@content').must_equal(content) }
    end

    describe '.render' do
      before { Vedeu.renderers.stubs(:render) }

      subject { described.render(content) }

      context 'when DRb is enabled' do
        let(:drb) { true }

        it { }
      end

      context 'when DRb is not enabled' do
      #   it 'sends the rendered interface to the Terminal' do
      #     Vedeu::Renderers::Terminal.expects(:render)
      #     subject.must_be_instance_of(Array)
      #   end
      end

      it { Vedeu.renderers.expects(:render).with(content); subject }
    end

  end # Output

end # Vedeu
