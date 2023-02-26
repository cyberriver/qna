import consumer from "./consumer"


consumer.subscriptions.create("QuestionsChannel", {
  connected() {
    console.log('CONNECTED QUESTION!');
    this.perform("subscribed")
    
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    this.perform("ubsubscribed")   
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    $('.questions').append(data)
  }
});
