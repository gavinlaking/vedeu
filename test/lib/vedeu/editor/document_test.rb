require 'test_helper'

module Vedeu

  module Editor

    describe Document do

      let(:described)  { Vedeu::Editor::Document }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          data: data,
          name: _name,
        }
      }
      let(:data)   {
        "Hydrogen\n"  \
        "Helium\n"    \
        "Lithium\n"
      }
      let(:_name)    { 'Vedeu::Editor::Document' }
      let(:border)   {
        Vedeu::Borders::Border.new({ name: _name, enabled: false })
      }
      let(:geometry) {
        Vedeu::Geometries::Geometry.new({ name: _name, x: 1, xn: 5, y: 1, yn: 5 })
      }
      let(:interface) {
        Vedeu::Interfaces::Interface.new({ name: _name })
      }

      before {
        Vedeu.borders.stubs(:by_name).with(_name).returns(border)
        Vedeu.geometries.stubs(:by_name).returns(geometry)
        Vedeu.interfaces.stubs(:by_name).with(_name).returns(interface)

        Vedeu.stubs(:direct_write)
        Vedeu.stubs(:render_output)
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@data').must_equal(data) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it do
          instance.instance_variable_get('@repository').
            must_equal(Vedeu.documents)
        end
      end

      describe 'accessors' do
        it do
          instance.must_respond_to(:attributes)
          instance.must_respond_to(:data)
          instance.must_respond_to(:data=)
          instance.must_respond_to(:name)
          instance.must_respond_to(:name=)
        end
      end

      describe '#execute' do
        subject { instance.execute }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("Hydrogen\nHelium\nLithium") }
      end

      describe '#delete_character' do
        subject { instance.delete_character }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }

        context 'when on the first column of the first row' do
          it { subject.must_be_instance_of(Vedeu::Editor::Document) }
        end

        context 'when on the first column of not the first row' do
          # @todo Add more tests.
        end

        context 'when not on the first column' do
          # @todo Add more tests.
        end
      end

      describe '#delete_line' do
        subject { instance.delete_line }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }
      end

      describe '#insert_character' do
        it { instance.must_respond_to(:insert_character) }

        context 'when the character is a Symbol' do
          let(:character) { :a }

          subject { instance.insert_character(character) }

          it { subject.must_equal(instance) }
        end
      end

      describe '#insert_line' do
        subject { instance.left }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }
      end

      describe '#line' do
        subject { instance.line }

        context 'when the line is empty' do
          let(:data) {}

          it { subject.must_equal(Vedeu::Editor::Line.new('')) }
        end

        context 'when the line is not empty' do
          it { subject.must_equal(Vedeu::Editor::Line.new('Hydrogen')) }
        end
      end

      describe '#lines' do
        let(:expected) {
          Vedeu::Editor::Lines.new([
            Vedeu::Editor::Line.new('Hydrogen'),
            Vedeu::Editor::Line.new('Helium'),
            Vedeu::Editor::Line.new('Lithium'),
          ])
        }

        subject { instance.lines }

        it { subject.must_equal(expected) }
      end

      describe '#reset!' do
        it { instance.must_respond_to(:reset!) }
      end

      describe '#refresh' do
        it { instance.must_respond_to(:refresh) }
      end

      describe '#down' do
        subject { instance.down }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }
      end

      describe '#left' do
        subject { instance.left }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }
      end

      describe '#right' do
        subject { instance.right }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }
      end

      describe '#up' do
        subject { instance.up }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }
      end

    end # Editor

  end # Editor

end # Vedeu
