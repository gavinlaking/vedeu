require 'test_helper'

module Vedeu

  describe CharBuilder do

    let(:described) { Vedeu::CharBuilder }

    # describe '#origin' do
    #   it 'returns the origin for the interface' do
    #     geometry = Geometry.new({ width: 5, height: 5 })
    #     geometry.origin.must_be_instance_of(Vedeu::Position)
    #     geometry.origin.y.must_equal(1)
    #     geometry.origin.x.must_equal(1)
    #   end

    #   it 'returns the origin for the interface' do
    #     geometry = Geometry.new({ width: 5, height: 5, centred: true })
    #     geometry.origin.must_be_instance_of(Vedeu::Position)
    #     geometry.origin.y.must_equal(10)
    #     geometry.origin.x.must_equal(38)
    #   end

    #   it 'returns the line position relative to the origin' do
    #     geometry = Geometry.new({ width: 5, height: 5 })
    #     geometry.origin(3).must_be_instance_of(Vedeu::Position)
    #     geometry.origin(3).y.must_equal(4)
    #     geometry.origin(3).x.must_equal(1)
    #   end

    #   it 'returns the origin for the interface when the interface' \
    #      ' is at a custom position' do
    #     geometry = Geometry.new({ width: 5, height: 5, x: 3, y: 6 })
    #     geometry.origin.must_be_instance_of(Vedeu::Position)
    #     geometry.origin.y.must_equal(6)
    #     geometry.origin.x.must_equal(3)
    #   end

    #   it 'returns the line position relative to the origin when the' \
    #      ' interface is at a custom position' do
    #     geometry = Geometry.new({ width: 5, height: 5, x: 3, y: 6 })
    #     geometry.origin(3).must_be_instance_of(Vedeu::Position)
    #     geometry.origin(3).y.must_equal(9)
    #     geometry.origin(3).x.must_equal(3)
    #   end
    # end

  end # CharBuilder

end # Vedeu
