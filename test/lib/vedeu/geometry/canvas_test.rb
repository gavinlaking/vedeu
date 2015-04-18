require 'test_helper'

module Vedeu

  describe Canvas do

    let(:described) { Vedeu::Canvas }
    let(:instance)  { described.canvas }
    let(:yn)        { 25 }
    let(:xn)        { 80 }

    before { instance.configure(yn, xn) }

    describe '.canvas' do
      it { instance.must_be_instance_of(described) }
    end

    describe '#configure' do
      it { instance.must_be_instance_of(described) }
    end

    describe '#c' do
      it { instance.c.must_equal([13, 41]) }
      it { instance.must_respond_to(:centre) }
    end

    describe '#cy' do
      it { instance.cy.must_equal(13) }
      it { instance.must_respond_to(:centre_y) }
    end

    describe '#cx' do
      it { instance.cx.must_equal(41) }
      it { instance.must_respond_to(:centre_x) }
    end

    describe '#o' do
      it { instance.o.must_equal(1) }
      it { instance.must_respond_to(:origin) }
    end

    describe '#height' do
      it { instance.height.must_equal(25) }
    end

    describe '#width' do
      it { instance.width.must_equal(80) }
    end

    describe '#y' do
      it { instance.y.must_equal(1) }
      it { instance.must_respond_to(:top) }
    end

    describe '#yn' do
      it { instance.yn.must_equal(25) }
      it { instance.must_respond_to(:bottom) }
      it { instance.must_respond_to(:height) }
    end

    describe '#x' do
      it { instance.x.must_equal(1) }
      it { instance.must_respond_to(:left) }
    end

    describe '#xn' do
      it { instance.xn.must_equal(80) }
      it { instance.must_respond_to(:right) }
      it { instance.must_respond_to(:width) }
    end

  end # Canvas

end # Vedeu
