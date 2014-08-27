require 'test_helper'

module Vedeu
  class ViewTest < View
    def render
      { interfaces: [] }
    end
  end

  describe View do
    describe '.render' do
      it 'returns' do
        ViewTest.render.must_equal([])
      end
    end
  end
end
