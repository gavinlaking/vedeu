require 'test_helper'

module Vedeu

	describe Chars do

    let(:described) { Vedeu::Chars }
    let(:instance)  { described.new }

    it { described.superclass.must_equal(Vedeu::Collection) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # Chars

end # Vedeu
