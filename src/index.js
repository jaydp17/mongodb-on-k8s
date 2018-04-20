const restify = require('restify');
const applyRoutes = require('./apply-routes');

const server = restify.createServer({
  name: 'mongodb-on-k8s',
  version: '1.0.0',
});

server.use(restify.plugins.acceptParser(server.acceptable));
server.use(restify.plugins.queryParser());
server.use(restify.plugins.bodyParser());

applyRoutes(server);

server.listen(process.env.PORT || 3000, () => {
  console.log('%s listening at %s', server.name, server.url);
});
