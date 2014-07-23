require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repositories/interface'

module Vedeu
  module Repositories
    describe Interface do
      before { Interface.reset }

      describe '.update' do
        it 'returns an Interface' do
          Interface.update('dummy', { name: 'dumber' })
            .must_be_instance_of(Vedeu::Interface)
        end

        it 'updates and returns the existing interface when the interface exists' do
          Interface.update('dummy', { name: 'dumber' }).name
            .must_equal('dumber')
        end

        it 'returns a new interface when the interface does not exist' do
          Interface.update('dummy', { name: 'dumber' }).name
            .must_equal('dumber')
        end
      end

      describe '.refresh' do
        it 'returns an Array' do
          Interface.refresh.must_be_instance_of(Array)
        end

        it 'returns the collection in order they should be drawn' do
          Interface.create({
            name:   '.refresh_1',
            width:  1,
            height: 1,
            z:      3,
            lines:  'alpha'
          }).enqueue
          Interface.create({
            name:   '.refresh_2',
            width:  1,
            height: 1,
            z:      1,
            lines:  'beta'
          }).enqueue
          Interface.create({
            name:   '.refresh_3',
            width:  1,
            height: 1,
            z:      2,
            lines:  'gamma'
          }).enqueue

          Interface.refresh.must_equal([
            "\e[1;1H \e[1;1H\e[1;1Hbeta",
            "\e[1;1H \e[1;1H\e[1;1Hgamma",
            "\e[1;1H \e[1;1H\e[1;1Halpha"
          ])
        end
      end

      describe '.entity' do
        it 'returns Interface' do
          Interface.entity.must_equal(Vedeu::Interface)
        end
      end
    end
  end
end
