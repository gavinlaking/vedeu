require 'test_helper'

module Vedeu

  describe ContentGeometry do

    let(:described) { Vedeu::ContentGeometry }
    let(:instance)  { described.new(interface) }
    let(:interface) {
      Vedeu::Interface.build do
        geometry do
          height 3
          width  5
        end
        name 'content_geometry'
      end
    }
    let(:lines) { [] }

    before do
      Vedeu.interfaces.reset
      interface.stubs(:lines).returns(lines)
    end

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@interface').must_equal(interface) }
    end

    describe '#inspect' do
      subject { instance.inspect }

      it { subject.must_equal('<Vedeu::ContentGeometry (y:1 x:1 yn:3 xn:5)>') }
    end

    describe '#yn' do
      subject { instance.yn }

      it { subject.must_be_instance_of(Fixnum) }

      context 'when the interface has content' do
        context 'when there is more lines than height' do
          let(:lines) {
            [
              [:line_1],
              [:line_2],
              [:line_3],
              [:line_4]
            ]
          }

          it { subject.must_equal(4) }
        end

        context 'when there is less lines than height' do
          it { subject.must_equal(3) }
        end
      end

      context 'when the interface does not have content' do
        it { subject.must_equal(3) }
      end
    end

    describe '#xn' do
      subject { instance.xn }

      it { subject.must_be_instance_of(Fixnum) }

      context 'when the interface has content' do
        context 'when there are more characters than width' do
          let(:lines) {
            [
              ['S', 'o', 'm', 'e', ' ', 't', 'e', 'x', 't', '.'],
              ['S', 'o', 'm', 'e'],
              ['S', 'o', 'm', 'e', ' ', 't', 'e', 'x', 't', '.', '.', '.'],
              ['S', 'o', 'm', 'e', ' ', 't', 'e'],
            ]
          }

          it { subject.must_equal(12) }
        end

        context 'when there are less characters than width' do
          let(:lines) {
            [
              ['S', 'o', 'm', 'e'],
              ['S', 'o', 'm', 'e'],
              ['S', 'o', 'm', 'e'],
              ['S', 'o', 'm', 'e'],
            ]
          }

          it { subject.must_equal(5) }
        end
      end

      context 'when the interface does not have content' do
        it { subject.must_equal(5) }
      end
    end

  end # ContentGeometry

end # Vedeu
