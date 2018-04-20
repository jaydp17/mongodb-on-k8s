const restify = require('restify');

const server = restify.createServer({
  name: 'mongodb-on-k8s',
  version: '1.0.0',
});

server.use(restify.plugins.acceptParser(server.acceptable));
server.use(restify.plugins.queryParser());
server.use(restify.plugins.bodyParser());

server.get('/', (req, res, next) => {
  res.send({ hello: 'world' });
  return next();
});

server.listen(process.env.PORT || 3000, () => {
  console.log('%s listening at %s', server.name, server.url);
});
