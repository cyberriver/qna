import consumer from "./consumer"

consumer.subscriptions.create("AnswersChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('CONNECTED ANSWER!');
   // this.perform("subscribed")
    //this.perform("get_user_data")    
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
   // this.perform("ubsubscribed")   
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data)
    $('.answers').append(data.answer)
  }
});
