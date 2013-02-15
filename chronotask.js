Events = new Meteor.Collection("events");

Session.set("timer", false);

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

  Template.timer.events({
    'click input' : function () {
      //Start the timer and add an event
      Session.set("timer", true);
      Events.insert({user_id: Meteor.userId(), start: new Date(), end: new Date()});
    }
  });


}

if (Meteor.isServer) {
  Meteor.startup(function () {
  });
}
