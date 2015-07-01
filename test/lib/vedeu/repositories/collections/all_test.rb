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

  describe EventCollection do

    let(:described) { Vedeu::EventCollection }
    let(:instance)  { described.new }

    it { described.superclass.must_equal(Vedeu::Collection) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # EventCollection

  describe InterfaceCollection do

    let(:described) { Vedeu::InterfaceCollection }
    let(:instance)  { described.new }

    it { described.superclass.must_equal(Vedeu::Collection) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # InterfaceCollection

  describe Keys do

    let(:described) { Vedeu::Keys }
    let(:instance)  { described.new }

    it { described.superclass.must_equal(Vedeu::Collection) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # Keys

  describe Lines do

    let(:described) { Vedeu::Lines }
    let(:instance)  { described.new }

    it { described.superclass.must_equal(Vedeu::Collection) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # Lines

  describe Streams do

    let(:described) { Vedeu::Streams }
    let(:instance)  { described.new }

    it { described.superclass.must_equal(Vedeu::Collection) }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # Streams

end # Vedeu
