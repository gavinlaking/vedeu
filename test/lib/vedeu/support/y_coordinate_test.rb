# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe YCoordinate do

    let(:described) { Vedeu::YCoordinate }
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

    describe '#y' do
      it { instance.must_respond_to(:y) }
    end

    describe '#bd' do
      subject { instance.bd }

      # it { subject.must_be_instance_of(Integer) }
      # it { subject.must_equal() }
    end

    describe '#by' do
      it { instance.must_respond_to(:by) }
    end

    describe '#bdn' do
      subject { instance.bdn }

      # it { subject.must_be_instance_of(Integer) }
      # it { subject.must_equal() }
    end

    describe '#byn' do
      it { instance.must_respond_to(:byn) }
    end

    describe '#d_dn' do
      subject { instance.d_dn }

      # it { subject.must_be_instance_of(Integer) }
      # it { subject.must_equal() }
    end

    describe '#bordered_height' do
      it { instance.must_respond_to(:bordered_height) }
    end

  end # YCoordinate

end # Vedeu
