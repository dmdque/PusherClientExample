var pusher = new Pusher('app_id', {
  authEndpoint: 'http://10.88.111.2:3000/v1/auth/pusher'
});

// Slanger backend
//var pusher = new Pusher('test123', {
  //wsHost: '54.164.144.11',
  //wsPort: '8080',
  //wssPort: '8080',
  //enabledTransports: ['ws', 'flash'],
  //authEndpoint: 'http://10.88.111.2:3000/v1/auth/pusher'
//});

console.log('connected?');
var channel = pusher.subscribe('private-test_channel');

channel.bind('client-my_event', function(data) {
  console.log(data)
  $('#chat-box').append('<p>' + data.message + '</p>')
  console.log('An event was triggered with message: ' + data.message);
});
