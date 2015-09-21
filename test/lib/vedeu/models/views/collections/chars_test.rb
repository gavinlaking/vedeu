require 'test_helper'

module Vedeu

  module Views

    describe Chars do

      let(:described) { Vedeu::Views::Chars }
      let(:instance)  { described.new }

      it { described.superclass.must_equal(Vedeu::Repositories::Collection) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

    end # Chars

  end # Views

end # Vedeu
