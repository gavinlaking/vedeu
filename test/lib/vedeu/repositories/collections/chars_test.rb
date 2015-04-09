require 'test_helper'

module Vedeu

  describe Chars do

    let(:described) { Vedeu::Chars }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Chars) }
    end

  end # Chars

end # Vedeu
