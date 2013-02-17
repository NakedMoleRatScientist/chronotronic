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

  Template.timer.status = function() {
    if (Session.get("timer") == true)
    {
      return "stop";
    }
    else
    {
      return "start";
    }
    
  };

  Template.events.size = function() {
    return Events.find({}).count();    
  }  

  Template.timer.time = function() {
    if (Session.get("eventId") != null)
    {
      //Nothing here yet.
    }
    return "00:00:00";

  }
  id = null;
  Template.timer.events({
    'click #start' : function () {
      //Start the timer and add an event
      Session.set("timer", true);
      if (Session.get("eventId") == null)
      {
        event = Events.insert({user_id: Meteor.userId(), start: new Date(), end: new Date()});
        Session.set("eventId", event);
        id = Meteor.setInterval(function() {
          Events.update(Session.get("eventId"), {$set: {end: new Date()}});
        }, 1000);
      }      
    }
    ,'click #stop' : function () {
      Session.set("timer",false);
      Meteor.clearInterval(id);
    }
  });


}

if (Meteor.isServer) {
  Meteor.startup(function () {
  });
}
