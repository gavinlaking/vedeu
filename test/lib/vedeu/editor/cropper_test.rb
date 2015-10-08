require 'test_helper'

module Vedeu

  module Editor

    describe Cropper do

      let(:described) { Vedeu::Editor::Cropper }
      let(:instance)  {
        described.new(lines: lines, name: _name, ox: ox, oy: oy)
      }
      let(:_name)  { 'editor_cropper' }
      let(:lines)  { Vedeu::Editor::Lines.new }
      let(:ox)     { 1 }
      let(:oy)     { 1 }

      let(:border) {
        Vedeu::Borders::Border.new(name: _name, enabled: false)
      }
      let(:geometry) {
        Vedeu::Geometry::Geometry.new(name:   _name,
                                        x:      1,
                                        y:      1,
                                        xn:     5,
                                        yn:     3)
      }
      let(:interface) {
        Vedeu::Interfaces::Interface.new(name: _name)
      }

      before do
        Vedeu.geometries.stubs(:by_name).with(_name).returns(geometry)
        Vedeu.borders.stubs(:by_name).with(_name).returns(border)
        Vedeu.interfaces.stubs(:by_name).with(_name).returns(interface)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@lines').must_equal(lines) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@ox').must_equal(ox) }
        it { instance.instance_variable_get('@oy').must_equal(oy) }
      end

      describe '#to_a' do
        subject { instance.to_a }

        context 'when there are no lines' do
          let(:lines) { Vedeu::Editor::Lines.new }

          it { subject.must_equal([]) }
        end

        context 'when there are lines' do
          let(:lines) {
            Vedeu::Editor::Lines.new([
              Vedeu::Editor::Line.new('Hydrogen'),
              Vedeu::Editor::Line.new('Helium'),
              Vedeu::Editor::Line.new('Lithium'),
              Vedeu::Editor::Line.new('Beryllium'),
              Vedeu::Editor::Line.new('Boron'),
            ])
          }

          it { subject.must_equal(['elium', 'ithiu', 'eryll']) }
        end
      end

      # describe '#viewport' do
      #   subject { instance.viewport }

      #   context 'when there are no lines' do
      #     let(:lines) { Vedeu::Editor::Lines.new }

      #     it { subject.must_equal([]) }
      #   end

      #   context 'when there are lines' do
      #     let(:lines) {
      #       Vedeu::Editor::Lines.new([
      #         Vedeu::Editor::Line.new('Hydrogen'),
      #         Vedeu::Editor::Line.new('Helium'),
      #         Vedeu::Editor::Line.new('Lithium'),
      #         Vedeu::Editor::Line.new('Beryllium'),
      #         Vedeu::Editor::Line.new('Boron'),
      #       ])
      #     }

      #     it { subject.must_equal(['elium', 'ithiu', 'eryll']) }

      #     context 'when oy is near the bottom' do
      #       let(:oy) { 6 }

      #       it { subject.must_equal([]) }
      #     end

      #     context 'when ox is nearly past the content width' do
      #       let(:oy) { 5 }
      #       let(:ox) { 10 }

      #       it 'returns only that which is visible, discarding empty lines' do
      #         subject.must_equal([])
      #       end
      #     end

      #     context 'when both oy and ox are effectively out of range' do
      #       let(:oy) { 10 }
      #       let(:ox) { 20 }

      #       it { subject.must_equal([]) }
      #     end
      #   end
      # end

    end # Cropper

  end # Editor

end # Vedeu
