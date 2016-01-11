### Vedeu.views

Define a view (content) for an interface.

The views declared within this block are stored in their respective
interface back buffers until a refresh event occurs. When the refresh
event is triggered, the back buffers are swapped into the front
buffers and the content here will be rendered.

Multiple views can be rendered inside a `views` block as the example
below shows:

  Vedeu.views do
    # view :some_interface do
    #   line do
    #     stream do
    #       left 'Title goes here', width: 35
    #     end
    #     stream do
    #       right Time.now.strftime('%H:%m'), width: 7
    #     end
    #   end
    # end

    # view :other_interface do
    #   lines do
    #     line 'This is content for the main interface.'
    #     line ''
    #     line 'Pretty easy eh?'
    #   end
    # end
  end
