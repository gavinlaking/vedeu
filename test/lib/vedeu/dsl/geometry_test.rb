require 'test_helper'

module Vedeu

  module DSL

    describe Geometry do

      describe '#centred' do
        it 'returns false if the value is false or nil' do
          skip
          interface = Vedeu.interface('iron') { centred(false) }
          interface.geometry.centred.must_equal(false)
        end

        it 'returns true' do
          skip
          interface = Vedeu.interface('iron') { centred! }
          interface.geometry.centred.must_equal(true)
        end
      end

      describe '#height' do
        it 'sets the attribute to the value' do
          Vedeu.interface 'iron' do
            height 6
          end

          Vedeu.use('iron').attributes[:geometry][:height].must_equal(6)
        end
      end

      describe '#width' do
        it 'sets the attribute to the value' do
          skip
          Vedeu.interface 'iron' do
            width 25
          end

          Vedeu.use('iron').attributes[:geometry][:width].must_equal(25)
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

      describe '#y' do
        it 'sets the attribute to the block if a block is given' do
          skip

          Vedeu.interface 'iron' do
            y { 6 }
          end.y.must_equal(6)
        end

        it 'sets the attribute to the value if a block is not given' do
          skip

          Vedeu.interface 'iron' do
            y 4
          end.y.must_equal(4)
        end
      end

    end # Geometry

  end # DSL

end # Vedeu
