require 'test_helper'

module Vedeu

  module Borders

    describe SetTitle do

      let(:described) { Vedeu::Borders::SetTitle }
      let(:instance)  { described.new(_name, title) }
      let(:_name)     {}
      let(:title)     {}
      let(:border)    {
        Vedeu::Borders::Border.new(name: _name, title: 'Some title')
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@title').must_equal(title) }
      end

      describe '.update' do
        let(:_name) { 'Vedeu::Borders::SetTitle' }

        subject { described.update(_name, title) }

        it { subject.must_be_instance_of(Vedeu::Borders::Border) }

        context 'when a name is given' do
          context 'when a border exists with the given name' do
            before do
              Vedeu.borders.stubs(:by_name).with(_name).returns(border)
            end

            context 'when a title is given' do
              let(:title) { 'Other title' }

              it { subject.title.must_equal(title) }
            end

            context 'when a title is not given' do
              it { subject.title.must_equal('') }
            end
          end

          context 'when no border exists with the given name' do
            before { Vedeu.borders.reset! }

            it 'registers a new border with the name' do
              subject
              Vedeu.borders.registered?(_name).must_equal(true)
            end

            context 'when a title is given' do
              let(:title) { 'Other title' }

              it 'sets the title of the new border' do
                subject
                Vedeu.borders.by_name(_name).title.must_equal(title)
              end
            end

            context 'when a title is not given' do
              it {
                subject
                Vedeu.borders.by_name(_name).title.must_equal('')
              }
            end
          end
        end

        context 'when a name is not given' do
          let(:_name) {}

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end
      end

      describe '#update' do
        it { instance.must_respond_to(:update) }
      end

    end # SetTitle

  end # Borders

end # Vedeu
