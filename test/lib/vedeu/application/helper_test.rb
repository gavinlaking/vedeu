require 'test_helper'

module Vedeu

  class HelperTestClass

    include Vedeu::Helper

  end # HelperTestClass

  describe Helper do

    let(:described) { Vedeu::HelperTestClass }
    let(:instance)  { described.new }

    context 'ClassMethods' do

    end

    context 'InstanceMethods' do

    end

  end # Helper

end # Vedeu
