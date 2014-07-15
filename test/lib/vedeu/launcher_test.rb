require_relative '../../test_helper'
require_relative '../../../lib/vedeu/launcher'

module Vedeu
  describe Launcher do
    describe '#execute!' do
      it 'needs a spec, please write one.' do
        skip
        Application.stub :start, nil do
          Launcher.new([]).execute!
        end
      end
    end
  end
end
