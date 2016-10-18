# PusherClientExample

Project to demonstrate issue described here: https://github.com/pusher/pusher-websocket-swift/issues/99.

It works properly when using Pusher as the backend, and only has the issue described when using Slanger (https://github.com/stevegraham/slanger) as the backend.

## Setup

Must set up authentication endpoint. Docs here: https://pusher.com/docs/authenticating_users#authentication_process. Rails example snippet:

    def pusher
      response = Pusher.authenticate(params[:channel_name], params[:socket_id])
        render json: response
    end

I also set up a convenience endpoint to trigger an event:

    def pusher_test
      Pusher.trigger('private-test_channel', 'client-my_event', {:username => 'apiserver', :message => 'hello world'})
    end

To run the web client:

    cd webclient/
    python -m SimpleHTTPServer 1337
