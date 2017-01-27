# When client-side subscription code gets invoked, it triggers the MessagesChannel#subscribed method, which streams messages that are broadcast to this channel, passing them along to the App.messages.received function
# the Subscription instance's send function corresponds to the subscription's channel's receive function; so MessagesChannel#receive method receives the payload sent by App.messages.send, using it to create and save a new message, and then broadcasts that new message out to all the subscribing clients
# This triggers the received function of all subscription instances to fire, appending the message to the appropriate chatroom's show page
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room-#{params['room']}:messages"
  end

  def receive(payload)
    Message.create(user: current_user, chatroom_id: params["room"], content: payload["message"])
  end
end
