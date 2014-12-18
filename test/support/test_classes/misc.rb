require 'vedeu/support/common'

module Vedeu

  class VedeuCommonClass

    include Vedeu::Common

    def defined_value_test(variable)
      defined_value?(variable)
    end

  end # VedeuCommonClass

end # Vedeu
