Meteor.startup ->
  
  Meteor.publish "Users", ->
    Meteor.users.find(_id: this.userId)

  Meteor.publish "Groups", -> 
    groups.find()
  
  Meteor.publish "Items", -> 
    items.find()
  
  Meteor.publish "Tries", ->
    tries.find()
    