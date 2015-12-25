# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module DSL

    describe View do

      let(:described) { Vedeu::DSL::View }
      let(:instance)  { described.new(model) }
      let(:model)     { Vedeu::Views::Composition.new }
      let(:client)    {}

      describe '#view' do
        subject {
          instance.view('dysprosium') do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::Views::Views) }
        it { subject[0].must_be_instance_of(Vedeu::Views::View) }

        context 'when the block is not given' do
          it { proc { instance.view }.must_raise(Vedeu::Error::RequiresBlock) }
        end
      end

      describe '#template_for' do
        let(:_name)    {}
        let(:filename) {}
        let(:object)   {}
        let(:content)  { "Hydrogen\nCarbon\nOxygen\nNitrogen" }
        let(:options)  { {} }

        subject { instance.template_for(_name, filename, object, options) }

        context 'when the name of the view is not given' do
          let(:filename) { 'my_interface.erb' }

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end

        context 'when the filename of the template is not given' do
          let(:_name) { 'my_interface' }

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end

        context 'when the name and filename are given' do
          let(:_name) { 'my_interface' }
          let(:filename) { 'my_interface.erb' }

          before do
            Vedeu::Templating::ViewTemplate.expects(:parse).
              with(object, filename, options).returns(content)
          end

          it { subject.must_be_instance_of(Vedeu::Views::Views) }
        end
      end

    end # View

  end # DSL

end # Vedeu
