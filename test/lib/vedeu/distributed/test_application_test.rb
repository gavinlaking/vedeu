# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe TestApplication do

    let(:described)  { Vedeu::TestApplication }
    let(:instance)   { described.new(attributes) }
    let(:attributes) { {} }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

    describe '#borders' do
      it { instance.must_respond_to(:borders) }
    end

    describe '#borders=' do
      it { instance.must_respond_to(:borders=) }
    end

    describe '#configuration' do
      it { instance.must_respond_to(:configuration) }
    end

    describe '#configuration=' do
      it { instance.must_respond_to(:configuration=) }
    end

    describe '#events' do
      it { instance.must_respond_to(:events) }
    end

    describe '#events=' do
      it { instance.must_respond_to(:events=) }
    end

    describe '#geometries' do
      it { instance.must_respond_to(:geometries) }
    end

    describe '#geometries=' do
      it { instance.must_respond_to(:geometries=) }
    end

    describe '#interfaces' do
      it { instance.must_respond_to(:interfaces) }
    end

    describe '#interfaces=' do
      it { instance.must_respond_to(:interfaces=) }
    end

    describe '#keymaps' do
      it { instance.must_respond_to(:keymaps) }
    end

    describe '#keymaps=' do
      it { instance.must_respond_to(:keymaps=) }
    end

    describe '#menus' do
      it { instance.must_respond_to(:menus) }
    end

    describe '#menus=' do
      it { instance.must_respond_to(:menus=) }
    end

    describe '#views' do
      it { instance.must_respond_to(:views) }
    end

    describe '#views=' do
      it { instance.must_respond_to(:views=) }
    end

    describe '.build' do
      subject { described.build(attributes) { } }

      it { subject.must_be_instance_of(String) }
    end

    describe '#lib_dir' do
      subject { instance.lib_dir }

      it { subject.must_be_instance_of(String) }
    end

  end # TestApplication

end # Vedeu
