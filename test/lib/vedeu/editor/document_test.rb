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
        Vedeu::Geometry::Geometry.new({ name: _name, x: 1, xn: 5, y: 1, yn: 5 })
      }
      let(:interface) {
        Vedeu::Interfaces::Interface.new({ name: _name })
      }

      before {
        Vedeu.borders.stubs(:by_name).with(_name).returns(border)
        Vedeu.geometries.stubs(:by_name).with(_name).returns(geometry)
        Vedeu.interfaces.stubs(:by_name).with(_name).returns(interface)

        Vedeu.stubs(:direct_write)
        Vedeu.stubs(:render_output)
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@data').must_equal(data) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it {
          instance.instance_variable_get('@repository').
            must_equal(Vedeu.documents)
        }
      end

      describe '.store' do
        before { Vedeu.documents.reset! }

        subject { described.store(attributes) }

        it { subject.must_be_instance_of(described) }

        it 'registers the instance with the repository' do
          Vedeu.documents.registered?(_name).must_equal(false)

          subject

          Vedeu.documents.registered?(_name).must_equal(true)
        end
      end

      describe 'accessors' do
        it {
          instance.must_respond_to(:attributes)
          instance.must_respond_to(:data)
          instance.must_respond_to(:data=)
          instance.must_respond_to(:name)
          instance.must_respond_to(:name=)
        }
      end

      describe '#delete_character' do
        it { instance.must_respond_to(:delete_character) }
      end

      describe '#delete_line' do
        it { instance.must_respond_to(:delete_line) }
      end

      describe '#down' do
        it { instance.must_respond_to(:down) }
      end

      describe '#execute' do
        subject { instance.execute }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("Hydrogen\nHelium\nLithium") }
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
        it { instance.must_respond_to(:insert_line) }
      end

      describe '#left' do
        it { instance.must_respond_to(:left) }
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

      describe '#right' do
        it { instance.must_respond_to(:right) }
      end

      describe '#up' do
        it { instance.must_respond_to(:up) }
      end

      describe '#bol' do
        it { instance.must_respond_to(:bol) }
      end

      describe '#eol' do
        it { instance.must_respond_to(:eol) }
      end

    end # Editor

  end # Editor

end # Vedeu
