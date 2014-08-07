require 'test_helper'
require 'vedeu/application'

module Vedeu
  describe Application do
    it 'returns an instance of Application' do
      Application.new.must_be_instance_of(Application)
    end
  end
end
