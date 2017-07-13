'use strict';
var proxy = require('express-http-proxy');
var express     = require('express');
var app = express();
var cors = require('cors');

app.use(cors());
app.use('/api/docs/',express.static('./swagger-ui/'));
app.use('/api/swagger/',express.static('./swagger/'));

var targeturl=process.env.TARGET_URL || 'www.google.fr';

app.use('/', proxy(targeturl));


var server_port = process.env.OPENSHIFT_NODEJS_PORT || 8080
var server_ip_address = process.env.OPENSHIFT_NODEJS_IP || '0.0.0.0'
app.listen(server_port, server_ip_address, function () {
console.log( "Listening on " + server_ip_address + ", server_port " + server_port + "  proxy to => "+targeturl);
});