Meteor.startup ->
  
  Meteor.publish "Users", ->
    Meteor.users.find(_id: this.userId)

  Meteor.publish "Groups", -> 
    groups.find()
  
  Meteor.publish "Items", -> 
    items.find()
  
  Meteor.publish "Tries", ->
    tries.find()
  
  Meteor.publish "Chats", ->
    chats.find()
  
  Meteor.publish "Matches", ->
    matches.find()
  
  Meteor.publish "Users", ->
    Meteor.users.find()
    