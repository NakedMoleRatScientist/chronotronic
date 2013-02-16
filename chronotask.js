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
      return "active";
    }
    else
    {
      return "inactive";
    }
    
  };

  Template.timer.time = function() {
    if (Session.get("eventId") != null)
    {
      return "00:00:00";
    }
  }

  Template.timer.events({
    'click #start' : function () {
      //Start the timer and add an event
      Session.set("timer", true);
      event = Events.insert({user_id: Meteor.userId(), start: new Date(), end: new Date()});
      Session.set("eventId", event);
    }
    ,'click #stop' : function () {
      Session.set("timer",false);
    }
  });


}

if (Meteor.isServer) {
  Meteor.startup(function () {
  });
}
