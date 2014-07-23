require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/output/output'
require_relative '../../../../lib/vedeu/support/terminal'

module Vedeu
  describe Output do
    describe '.render' do
      it 'returns an Array' do
        output = "\e[3;3H            \e[3;3H" \
                 "\e[3;3HSome text...\e[3;3H"
        Repositories::Interface.stub(:refresh, [output]) do
          Terminal.stub(:output, output) do
            Output.render.first.must_equal(output)
          end
        end
      end
    end
  end
end
