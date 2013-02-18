Events = new Meteor.Collection("events");

Session.set("timer", false);
Session.set("eventId", null);


if (Meteor.isClient) {
  Template.nav.profile = function () {
    user = Meteor.user()
    if (user.name != null)
    {
      return name;
    }
    else
    {
      return "noname";
    }
  };


  Template.events.size = function() {
    return Events.find({}).count();    
  }  

}
