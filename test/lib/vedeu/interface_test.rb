require_relative '../../test_helper'

module Vedeu
  describe Interface do
    let(:klass)    { Interface }
    let(:options)  { {} }

    before do
      Vedeu::Terminal.stubs(:width).returns(80)
      Vedeu::Terminal.stubs(:height).returns(25)
      Vedeu::Terminal.stubs(:show_cursor)
      Vedeu::Terminal.stubs(:hide_cursor)
    end
  end
end
