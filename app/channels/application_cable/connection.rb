# defines connection class
# connection instance gets instantiated from this class every time a WebSocket request is accepted by the server
# since a new connection is instantiated every time a consumer sends the initial WebSocket request, forming a connection-consumer pair, this is the perfect place to authorize the incoming request, and find the current user
# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    # connect method will be called for us when the consumer sends the WebSocket request
    def connect
      self.current_user = find_verified_user
    end

    protected
    # sets identifier to current_user
    # the connection identifier can be used to find the specific connection. It's important to note that the method we mark as our identifier will create a delegate by the same name on any channel instances that are associated with this connection, which enables use of the method, current_user, in Messages Channel
      def find_verified_user
        if current_user = User.find_by(id: cookies.signed[:user_id])
          current_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
