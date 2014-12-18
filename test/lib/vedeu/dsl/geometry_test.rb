require 'test_helper'

module Vedeu

  module DSL

    describe Geometry do

      let(:described) { Vedeu::DSL::Geometry.new(model) }
      let(:model)     { Vedeu::Geometry.new }

      describe '#initialize' do
        it { return_type_for(described, Vedeu::DSL::Geometry) }
        it { assigns(described, '@model', model) }
      end

      describe '#height' do
        it 'sets the attribute to the value' do
          Vedeu.interface 'iron' do
            height 6
          end

          Vedeu.use('iron').attributes[:geometry][:height].must_equal(6)
        end
      end

      describe '#x' do
        it 'sets the attribute to the block if a block is given' do
          Vedeu.interface 'iron' do
            x { 9 }
          end

          Vedeu.use('iron').geometry.x.must_equal(9)
        end

        it 'sets the attribute to the value if a block is not given' do
          Vedeu.interface 'iron' do
            x 7
          end

          Vedeu.use('iron').attributes[:geometry][:x].must_equal(7)
        end
      end

    end # Geometry

  end # DSL

end # Vedeu
