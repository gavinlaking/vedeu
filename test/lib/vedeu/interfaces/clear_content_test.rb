# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_clear_view_).must_equal(true) }
    it { Vedeu.bound?(:_clear_view_content_).must_equal(true) }
  end

  module Interfaces

    describe ClearContent do

      let(:described) { Vedeu::Interfaces::ClearContent }
      let(:instance)  { described.new(_name) }
      let(:_name)     { :vedeu_interfaces_clear }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.clear_content_by_name' do
        it { described.must_respond_to(:clear_content_by_name) }
      end

      describe '#render' do
        let(:interface) {
          Vedeu::Interfaces::Interface.new(name: _name, visible: visible)
        }
        let(:colour)    { interface.colour }
        let(:visible)   { true }
        let(:geometry)  {
          Vedeu::Geometries::Geometry.new(name: _name, x: 1, y: 1, xn: 2, yn: 2)
        }
        let(:output) {
          [
            [
              Vedeu::Cells::Clear.new(colour:   colour,
                                      name:     _name,
                                      position: [1, 1]),
              Vedeu::Cells::Clear.new(colour:   colour,
                                      name:     _name,
                                      position: [1, 2]),
            ], [
              Vedeu::Cells::Clear.new(colour:   colour,
                                      name:     _name,
                                      position: [2, 1]),
              Vedeu::Cells::Clear.new(colour:   colour,
                                      name:     _name,
                                      position: [2, 2]),
            ]
          ]
        }

        before do
          Vedeu.interfaces.stubs(:by_name).returns(interface)
          Vedeu.geometries.stubs(:by_name).returns(geometry)
          Vedeu.stubs(:direct_write)
          Vedeu.stubs(:buffer_update)
        end

        subject { instance.render }

        # it { subject.must_be_instance_of(Vedeu::Buffers::View) }
        it do
          Vedeu.expects(:direct_write)
          subject
        end
        it do
          Vedeu.expects(:buffer_update)
          subject
        end
        # it { subject.must_equal(output) }
      end

    end # ClearContent

  end # Interfaces

end # Vedeu
