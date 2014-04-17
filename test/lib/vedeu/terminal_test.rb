require_relative '../../test_helper'

module Vedeu
  describe Terminal do
    let(:klass)    { Terminal }
    let(:instance) { klass.new }
    let(:console)  { stub }

    before do
      IO.stubs(:console).returns(console)
      console.stubs(:winsize).returns([25, 80])
    end

    it 'returns an instance of self' do
      instance.must_be_instance_of(Vedeu::Terminal)
    end

    describe '#width' do
      it 'returns the width of the terminal' do
        instance.width.must_equal(80)
      end
    end

    describe '#height' do
      it 'returns the height of the terminal' do
        instance.height.must_equal(25)
      end
    end
  end
end
