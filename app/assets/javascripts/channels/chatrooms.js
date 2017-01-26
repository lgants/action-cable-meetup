//= require cable
//= require_self
//= require_tree .

// instantiates Action Cable consumer on the client-side, telling it to initiate a WebSocket request and maintain a persistent connection with ws://localhost:3000/cable

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();

}).call(this);
