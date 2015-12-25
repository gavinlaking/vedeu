# frozen_string_literal: true

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
        Vedeu::Geometries::Geometry.new(name:   _name,
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

      describe '#viewport' do
        subject { instance.viewport }

        context 'when there are no lines' do
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
          let(:expected) {
            [
              "\e[1;1H\e[39m\e[49m\e[24m\e[22m\e[27me",
              "\e[1;2H\e[39m\e[49m\e[24m\e[22m\e[27ml",
              "\e[1;3H\e[39m\e[49m\e[24m\e[22m\e[27mi",
              "\e[1;4H\e[39m\e[49m\e[24m\e[22m\e[27mu",
              "\e[1;5H\e[39m\e[49m\e[24m\e[22m\e[27mm",
              "\e[2;1H\e[39m\e[49m\e[24m\e[22m\e[27mi",
              "\e[2;2H\e[39m\e[49m\e[24m\e[22m\e[27mt",
              "\e[2;3H\e[39m\e[49m\e[24m\e[22m\e[27mh",
              "\e[2;4H\e[39m\e[49m\e[24m\e[22m\e[27mi",
              "\e[2;5H\e[39m\e[49m\e[24m\e[22m\e[27mu",
              "\e[3;1H\e[39m\e[49m\e[24m\e[22m\e[27me",
              "\e[3;2H\e[39m\e[49m\e[24m\e[22m\e[27mr",
              "\e[3;3H\e[39m\e[49m\e[24m\e[22m\e[27my",
              "\e[3;4H\e[39m\e[49m\e[24m\e[22m\e[27ml",
              "\e[3;5H\e[39m\e[49m\e[24m\e[22m\e[27ml"
            ]
          }

          it { subject.size.must_equal(15) }
          it { subject.map(&:to_s).must_equal(expected) }
        end
      end

    end # Cropper

  end # Editor

end # Vedeu
