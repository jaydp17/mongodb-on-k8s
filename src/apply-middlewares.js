/**
 * Sets the name of the pod which is responding in the response header
 */
function setPodNameInHeader(req, res, next) {
  const podName = process.env.KUBERNETES_POD_NAME;
  if (podName) {
    res.header('KUBERNETES_POD_NAME', podName);
  }
  next();
}

module.exports = server => {
  server.use(setPodNameInHeader);
};
