
groups = new Meteor.Collection('Groups')
groups.allow({
  insert: function (userId, doc) {
    return (userId && _.contains(doc.managers, userId));
  },
  update: function (userId, doc, fields, modifier) {
    return (userId && _.contains(doc.managers, userId));
  },
  remove: function (userId, doc) {
    return (userId && _.contains(doc.managers, userId));
  },
  fetch: ['managers']
})

items = new Meteor.Collection('Items')
items.allow({
  insert: function (userId, doc) {
    group = groups.findOne({_id:doc.group})
    return (userId && _.contains(group.managers, userId));
  },
  update: function (userId, doc, fields, modifier) {
    return (userId && _.contains(group.managers, userId));
  },
  remove: function (userId, doc) {
    return (userId && _.contains(group.managers, userId));
  },
  fetch: ['group']
})

tries = new Meteor.Collection('Tries')
tries.allow({
  insert: function (userId, doc) {
    return (userId && doc.userId == userId);
  },
  update: function (userId, doc, fields, modifier) {
    return (userId && doc.userId == userId);
  },
  remove: function (userId, doc) {
    return (userId && doc.userId == userId);
  },
  fetch: ['userId']
})