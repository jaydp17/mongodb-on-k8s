const mongoose = require('mongoose');

mongoose.connect(process.env.MONGO_URL || 'mongodb://localhost/kubernetes');

const Person = mongoose.model('Person', { name: String });

/**
 * Saves the name for the person
 * @param {string} name new name of the person
 * @returns {Promise<{oldName, newName}>}
 */
async function setName(name) {
  const person = await getPerson();
  const oldName = person.name;
  person.name = name;
  await person.save();
  return { oldName, newName: person.name };
}

/**
 * Gets the last stored name of the person
 * @returns {Promise<string>}
 */
async function getName() {
  const person = await getPerson();
  return person.name;
}

/**
 * It checks if the person is already there,
 * if not it creates one and returns
 * @returns {Promise<Person>}
 */
async function getPerson() {
  const person = await Person.findOne();
  if (!person) {
    return new Person({ name: '' });
  }
  return person;
}

module.exports = { setName, getName };
