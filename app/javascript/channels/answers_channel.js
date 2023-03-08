import consumer from "./consumer"

$(document).on('turbolinks:load', function (){

  if((gon.controller_name === 'questions') && (gon.controller_action === 'show')){
    consumer.subscriptions.create({
      channel:"AnswersChannel",
      id: gon.params_id}  , 
    
    {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log('CONNECTED ANSWER!');
      
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server   
      },
    
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log(data)
        $('.answers').append(data.answer)
      }
    });
  };
  
});



