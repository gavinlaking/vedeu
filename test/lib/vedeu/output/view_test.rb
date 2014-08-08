require 'test_helper'
require 'vedeu/output/view'

module Vedeu
  describe View do
    describe '.render' do
      it 'returns attributes suitable for Composition' do
        View.render({ name: 'dummy' }).must_be_instance_of(Array)
      end
    end
  end
end
