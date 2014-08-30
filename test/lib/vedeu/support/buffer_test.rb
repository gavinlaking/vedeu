require 'test_helper'

module Vedeu
  describe Buffer do
    let(:vars) {
      {
        back: '',
        front: '',
        interface: mock('Interface'),
      }
    }

    describe '#initialize' do
      it 'returns a Buffer instance when all the vars are set' do
        #vars = { name: 'interface', clear: '', current: '', group: '', next: '' }
        Buffer.new(vars).must_be_instance_of(Buffer)
      end

      it 'raises an exception if a var is not set' do
        vars = {}
        proc { Buffer.new(vars) }.must_raise(KeyError)
      end
    end

    describe '#enqueue' do
      it 'creates a new Buffer instance with the sequence assigned to @_next' do
        buffer     = Buffer.new(vars)
        new_buffer = buffer.enqueue('some_sequence')

        buffer.back.must_equal('')
        new_buffer.wont_equal(buffer)
        new_buffer.back.must_equal('some_sequence')
      end
    end

    describe '#refresh' do
      it 'renders the fresh content if available' do
        interface = Interface.new
        buffer    = Buffer.new({ back: interface, front: nil, interface: interface })
        Terminal.stub(:output, '') do
          buffer.refresh.must_be_instance_of(Buffer)
          buffer.refresh.wont_equal(buffer)
        end
      end

      it 'clears the interface if no content is available' do
        interface = Interface.new
        buffer    = Buffer.new({ back: nil, front: nil, interface: interface })
        Terminal.stub(:output, '') do
          buffer.refresh.must_equal(buffer)
        end
      end

      it 'renders the previous/old content if nothing new has arrived' do
        interface = Interface.new
        buffer    = Buffer.new({ back: nil, front: interface, interface: interface })
        Terminal.stub(:output, '') do
          buffer.refresh.must_equal(buffer)
        end
      end
    end

    describe '#render' do
      it 'renders the interface and returns the Buffer instance' do
        interface = Interface.new
        buffer = Buffer.new({ back: nil, front: nil, interface: interface })
        Terminal.stub(:output, '') do
          buffer.render.must_equal(buffer)
        end
      end
    end

    describe '#clear' do
      it 'clears the interface and returns the Buffer instance' do
        interface = Interface.new
        buffer = Buffer.new({ back: nil, front: nil, interface: interface })
        Terminal.stub(:output, '') do
          buffer.clear.must_equal(buffer)
        end
      end
    end
  end
end
