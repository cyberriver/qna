import consumer from "./consumer"

$(document).on('turbolinks:load', function (){

   var commentableType = gon.commentable_type;
   var commentableId = gon.commentable_id;
   var channelIdParameter = gon.params_id;
   console.log("Initiation commentableType channelIdParameter: " + channelIdParameter+ " commentableType: " + commentableType + " commentableId : " + commentableId );

  //  if (gon.params_id) {
  //      var channelIdParameter =  gon.params_id

  //  } else {
  //      var channelIdParameter =  "questions#index"
  //  }

    consumer.subscriptions.create({
      channel:"CommentsChannel",
      id: channelIdParameter}, 
    
    {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log('CONNECTED COMMENTS! with channelIdParameter:' + channelIdParameter );
      
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server   
      },
    
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log(data);
        $('#'+data.commentable_type + '_' + data.commentable_id +'_comments').append(data.comment);
        $("#"+data.commentable_type + "_" + data.commentable_id  +"_comments_count").text(data.comments_count);
      }
    });

  
});
