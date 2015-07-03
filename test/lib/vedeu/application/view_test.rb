require 'test_helper'

module Vedeu

  class ViewTestClass

    include Vedeu::View

  end # ViewTestClass

  describe View do

    let(:described) { Vedeu::ViewTestClass }
    let(:instance)  { described.new }

    context 'ClassMethods' do

    end

    context 'InstanceMethods' do

    end

  end # View

end # Vedeu
