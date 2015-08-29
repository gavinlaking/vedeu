require 'test_helper'

module Vedeu

  module Editor

    describe Document do

      let(:described) { Vedeu::Editor::Document }
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
      let(:_name)  { 'Vedeu::Editor::Document' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@data').must_equal(data) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it {
          instance.instance_variable_get('@repository').
            must_equal(Vedeu.documents)
        }
      end

      describe 'accessors' do
        it { instance.must_respond_to(:attributes) }
        it { instance.must_respond_to(:data) }
        it { instance.must_respond_to(:data=) }
        it { instance.must_respond_to(:name) }
        it { instance.must_respond_to(:name=) }
      end

      describe '#clear' do
        subject { instance.clear }

      end

      describe '#delete_character' do
        let(:y) { 0 }
        let(:x) { 0 }

        subject { instance.delete_character }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }

        # it { skip }
      end

      describe '#delete_line' do
        let(:y) { 0 }

        subject { instance.delete_line }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }

        # it { skip }
      end

      describe '#insert_character' do
        let(:character) { 'a' }

        subject { instance.insert_character(character) }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }

        # it { skip }

        context 'when the character is a Symbol' do
          let(:character) { :a }

          it { subject.must_equal(instance) }
        end
      end

      describe '#insert_line' do
        let(:y) { 2 }

        subject { instance.insert_line }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }

        # it { skip }
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

        # context 'when y is set' do
        #   let(:y) { 2 }

        #   it { subject.must_equal(Vedeu::Editor::Line.new('Lithium')) }
        # end
      end

      describe '#lines' do
        subject { instance.lines }

        context 'when the data is empty' do
          let(:data) {}
          let(:expected) {
            Vedeu::Editor::Lines.new([Vedeu::Editor::Line.new])
          }

          it { subject.must_equal(expected) }
        end

        context 'when the data is not empty' do
          let(:expected) {
            Vedeu::Editor::Lines.new([
              Vedeu::Editor::Line.new('Hydrogen'),
              Vedeu::Editor::Line.new('Helium'),
              Vedeu::Editor::Line.new('Lithium'),
            ])
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#render' do
        let(:data) {
          Vedeu::Editor::Lines.new([
            Vedeu::Editor::Line.new('A'),
            Vedeu::Editor::Line.new('B'),
            Vedeu::Editor::Line.new('C'),
          ])
        }
        let(:output) { "\e[1;1HA\e[2;1HB\e[3;1HC\e[1;1H\e[?25h" }

        before { Vedeu::Direct.stubs(:write) }

        subject { instance.render }

        it {
          Vedeu::Direct.expects(:write).with(value: output, x: 1, y: 1)
          subject
        }
      end

      describe '#reset!' do
        subject { instance.reset! }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }
      end

      describe '#retrieve' do
        subject { instance.retrieve }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("Hydrogen\nHelium\nLithium") }
      end

    end # Editor

  end # Editor

end # Vedeu
