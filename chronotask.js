Events = new Meteor.Collection("events");

Session.set("timer", false);
Session.set("eventId", null);


if (Meteor.isClient) {

  Template.events.size = function() {
    return Events.find({}).count();    
  }  

}
