# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe XCoordinate do

    let(:described) { Vedeu::XCoordinate }
    let(:instance)  { described.new(geometry) }
    let(:geometry)  {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get("@geometry").must_equal(geometry) }
    end

    describe '#d' do
      subject { instance.d }

      # it { subject.must_be_instance_of(Integer) }
      # it { subject.must_equal() }
    end

    describe '#x' do
      it { instance.must_respond_to(:x) }
    end

    describe '#bd' do
      subject { instance.bd }

      # it { subject.must_be_instance_of(Integer) }
      # it { subject.must_equal() }
    end

    describe '#bx' do
      it { instance.must_respond_to(:bx) }
    end

    describe '#bdn' do
      subject { instance.bdn }

      # it { subject.must_be_instance_of(Integer) }
      # it { subject.must_equal() }
    end

    describe '#bxn' do
      it { instance.must_respond_to(:bxn) }
    end

    describe '#d_dn' do
      subject { instance.d_dn }

      # it { subject.must_be_instance_of(Integer) }
      # it { subject.must_equal() }
    end

    describe '#bordered_width' do
      it { instance.must_respond_to(:bordered_width) }
    end

  end # XCoordinate

end # Vedeu
