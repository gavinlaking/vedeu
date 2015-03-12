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
      it { instance.must_be_instance_of(Vedeu::RefreshCursor) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
    end

  end # RefreshCursor

end # Vedeu
