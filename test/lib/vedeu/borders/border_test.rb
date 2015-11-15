require 'test_helper'

module Vedeu

  module Borders

    describe Border do

      let(:described)  { Vedeu::Borders::Border }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          bottom_left:  'm',
          bottom_right: 'j',
          caption:      '',
          client:       nil,
          colour:       nil,
          enabled:      false,
          horizontal:   'q',
          name:         _name,
          parent:       nil,
          repository:   Vedeu.borders,
          show_bottom:  true,
          show_left:    true,
          show_right:   true,
          show_top:     true,
          style:        nil,
          title:        '',
          top_left:     'l',
          top_right:    'k',
          vertical:     'x',
        }
      }
      let(:geometry) {}
      let(:_name)    { 'borders' }

      describe '.build' do
        subject {
          described.build(attributes) do
            horizontal '~'
          end
        }

        it { subject.must_be_instance_of(described) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

      describe 'accessors' do
        it {
          instance.must_respond_to(:attributes)
          instance.must_respond_to(:bottom_left)
          instance.must_respond_to(:bottom_left=)
          instance.must_respond_to(:bottom_right)
          instance.must_respond_to(:bottom_right=)
          instance.must_respond_to(:caption)
          instance.must_respond_to(:caption=)
          instance.must_respond_to(:horizontal)
          instance.must_respond_to(:horizontal=)
          instance.must_respond_to(:show_bottom)
          instance.must_respond_to(:bottom?)
          instance.must_respond_to(:show_bottom=)
          instance.must_respond_to(:show_left)
          instance.must_respond_to(:left?)
          instance.must_respond_to(:show_left=)
          instance.must_respond_to(:show_right)
          instance.must_respond_to(:right?)
          instance.must_respond_to(:show_right=)
          instance.must_respond_to(:show_top)
          instance.must_respond_to(:top?)
          instance.must_respond_to(:show_top=)
          instance.must_respond_to(:title)
          instance.must_respond_to(:title=)
          instance.must_respond_to(:top_left)
          instance.must_respond_to(:top_left=)
          instance.must_respond_to(:top_right)
          instance.must_respond_to(:top_right=)
          instance.must_respond_to(:vertical)
          instance.must_respond_to(:vertical=)
          instance.must_respond_to(:name)
          instance.must_respond_to(:enabled)
          instance.must_respond_to(:enabled=)
          instance.must_respond_to(:enabled?)
        }
      end

      describe '#deputy' do
        subject { instance.deputy }

        it 'returns the DSL instance' do
          subject.must_be_instance_of(Vedeu::Borders::DSL)
        end
      end

      describe '#enabled?' do
        subject { instance.enabled? }

        it { subject.must_be_instance_of(FalseClass) }

        context 'when true' do
          let(:attributes) {
            {
              enabled: true,
              name:    _name,
            }
          }

          it { subject.must_be_instance_of(TrueClass) }
        end
      end

      describe '#bottom?' do
        subject { instance.bottom? }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:attributes) {
            {
              enabled:     true,
              name:        _name,
              show_bottom: false,
            }
          }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#left?' do
        subject { instance.left? }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:attributes) {
            {
              enabled:   true,
              name:      _name,
              show_left: false,
            }
          }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#right?' do
        subject { instance.right? }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:attributes) {
            {
              enabled:    true,
              name:       _name,
              show_right: false,
            }
          }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#top?' do
        subject { instance.top? }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:attributes) {
            {
              enabled:  true,
              name:     _name,
              show_top: false,
            }
          }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

    end # Border

  end # Borders

end # Vedeu
