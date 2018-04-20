const db = require('./db');

module.exports = server => {
  server.get('/name', async (req, res, next) => {
    try {
      const name = await db.getName();
      res.send({ name });
      next();
    } catch (error) {
      next(error);
    }
  });

  server.put('/name/:newName', async (req, res, next) => {
    const name = req.params['newName'];
    if (!name) {
      return next(new Error('name is required'));
    }
    try {
      const { oldName, newName } = await db.setName(name);
      res.send({ oldName, newName });
      next();
    } catch (error) {
      next(error);
    }
  });

  server.get('/', (req, res, next) => {
    res.send({ hello: 'world' });
    next();
  });
};
