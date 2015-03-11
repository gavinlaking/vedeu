require 'test_helper'

module Vedeu

  describe Chars do

    let(:described) { Vedeu::Chars }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Chars) }
    end

  end # Chars

  describe Events do

    let(:described) { Vedeu::Events }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Events) }
    end

  end # Events

  describe Interfaces do

    let(:described) { Vedeu::Interfaces }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Interfaces) }
    end

  end # Interfaces

  describe Keys do

    let(:described) { Vedeu::Keys }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Keys) }
    end

  end # Keys

  describe Lines do

    let(:described) { Vedeu::Lines }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Lines) }
    end

  end # Lines

  describe Streams do

    let(:described) { Vedeu::Streams }
    let(:instance)  { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Streams) }
    end

  end # Streams

end # Vedeu
