require 'test_helper'

module Vedeu

  describe RefreshCursor do

    let(:described) { Vedeu::RefreshCursor }
    let(:instance)  { described.new(_name) }
    let(:_name)     { 'refresh_cursor' }

    before do
      Vedeu::Terminal.stubs(:output)
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
    end

    # describe '.render' do
    #   subject { described.render(_name) }

    #   it 'renders the cursor in the terminal' do
    #     Vedeu::Terminal.expects(:output).with("\e[1;1H\e[?25l")
    #     subject
    #   end

    #   context 'when the view should be refreshed' do
    #   end

    #   context 'when the view should not be refreshed' do
    #   end
    # end

  end # RefreshCursor

end # Vedeu
