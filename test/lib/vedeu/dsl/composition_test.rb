require 'test_helper'

module Vedeu

  module DSL

    describe Composition do

      let(:described) { Vedeu::DSL::Composition }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Composition.new }
      let(:client)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@model').must_equal(model) }
        it { instance.instance_variable_get('@client').must_equal(client) }
      end

      describe '#view' do
        subject {
          instance.view('dysprosium') do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::InterfaceCollection) }
        it { subject.first.must_be_instance_of(Vedeu::Interface) }

        context 'when the block is not given' do
          it { proc { instance.view }.must_raise(InvalidSyntax) }
        end
      end

      describe '#template_for' do
        let(:_name)    {}
        let(:filename) {}
        let(:object)   {}
        let(:content)  { "Hydrogen\nCarbon\nOxygen\nNitrogen" }
        let(:as_lines) {
          [
            Vedeu::Line.new(streams: [Vedeu::Stream.new(value: 'Hydrogen')]),
            Vedeu::Line.new(streams: [Vedeu::Stream.new(value: 'Carbon')]),
            Vedeu::Line.new(streams: [Vedeu::Stream.new(value: 'Oxygen')]),
            Vedeu::Line.new(streams: [Vedeu::Stream.new(value: 'Nitrogen')])
          ]
        }

        subject { instance.template_for(_name, filename, object) }

        context 'when the name of the view is not given' do
          let(:filename) { 'my_interface.erb' }

          it { proc { subject }.must_raise(MissingRequired) }
        end

        context 'when the filename of the template is not given' do
          let(:_name) { 'my_interface' }

          it { proc { subject }.must_raise(MissingRequired) }
        end

        context 'when the name and filename are given' do
          let(:_name) { 'my_interface' }
          let(:filename) { 'my_interface.erb' }

          before do
            Vedeu::Template.expects(:parse).
              with(object, filename).returns(content)
          end

          it { subject.must_be_instance_of(Vedeu::InterfaceCollection) }
        end
      end

    end # Composition

  end # DSL

end # Vedeu
