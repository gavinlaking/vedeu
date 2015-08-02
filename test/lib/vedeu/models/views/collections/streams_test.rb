require 'test_helper'

module Vedeu

  module Views

    describe Streams do

      let(:described) { Vedeu::Views::Streams }
      let(:instance)  { described.new }

      it { described.superclass.must_equal(Vedeu::Collection) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

    end # Streams

  end # Views

end # Vedeu
