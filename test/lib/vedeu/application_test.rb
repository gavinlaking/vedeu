require_relative '../../test_helper'
require_relative '../../../lib/vedeu/application'

module Vedeu
  describe Application do
    describe '.start' do
      it 'returns a NilClass when the application should run interactively' do
        skip
        # Application.start({ interactive: true }).must_be_instance_of(NilClass)
      end

      it 'returns a NilClass when the application should run once' do
        skip
        # Application.start({ interactive: false }).must_be_instance_of(NilClass)
      end
    end
  end
end
