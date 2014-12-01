var express, app, request,server;
//require('Livescript');
//require('coffee-script/register');
express = require('express');
app = express();
routes = require('cloud/routes.js');
app.set('views', 'cloud/views');
app.set('view engine', 'ejs');
routes(app);
app.on('start', function() {
  return console.log('Application started.');
});

server = app.listen(3000);

server.on('listening', function() {
  return console.log('Server listening.');
});
