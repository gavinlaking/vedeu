require 'test_helper'

module Vedeu

  module Borders

    describe SetCaption do

      let(:described) { Vedeu::Borders::SetCaption }
      let(:instance)  { described.new(_name, caption) }
      let(:_name)     {}
      let(:caption)   {}
      let(:border)    {
        Vedeu::Borders::Border.new(name: _name, caption: 'Some caption')
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@caption').must_equal(caption) }
      end

      describe '.update' do
        let(:_name) { 'Vedeu::Borders::SetCaption' }

        subject { described.update(_name, caption) }

        it { subject.must_be_instance_of(Vedeu::Borders::Border) }

        context 'when a name is given' do
          context 'when a border exists with the given name' do
            before do
              Vedeu.borders.stubs(:by_name).with(_name).returns(border)
            end

            context 'when a caption is given' do
              let(:caption) { 'Other caption' }

              it { subject.caption.must_equal(caption) }
            end

            context 'when a caption is not given' do
              it { subject.caption.must_equal('') }
            end
          end

          context 'when no border exists with the given name' do
            before { Vedeu.borders.reset! }

            it 'registers a new border with the name' do
              subject
              Vedeu.borders.registered?(_name).must_equal(true)
            end

            context 'when a caption is given' do
              let(:caption) { 'Other caption' }

              it 'sets the caption of the new border' do
                subject
                Vedeu.borders.by_name(_name).caption.must_equal(caption)
              end
            end

            context 'when a caption is not given' do
              it {
                subject
                Vedeu.borders.by_name(_name).caption.must_equal('')
              }
            end
          end
        end
      end

      describe '#update' do
        it { instance.must_respond_to(:update) }
      end

    end # SetCaption

  end # Borders

end # Vedeu
