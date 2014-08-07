require 'test_helper'

require 'vedeu/output/dsl_parser'

module Vedeu
  describe DSLParser do
    it 'returns attributes suitable for Composition' do
      DSLParser.parse({ name: 'dummy' }).must_equal(
        {
          interfaces: [
            {
              name: 'dummy'
            }
          ]
        }
      )
    end
  end
end
