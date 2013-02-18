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

Template.timer.time = function() {
  if (Session.get("eventId") != null)
  {
    e = Events.findOne(Session.get("eventId"));
    return e.seconds.toString().toTime();
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
      event = Events.insert({user_id: Meteor.userId(), seconds: 0});
      Session.set("eventId", event);
    }
    id = Meteor.setInterval(function() {
      Events.update(Session.get("eventId"), {$inc: {seconds: 1}});
    }, 1000);
    
  }
  ,'click #stop' : function () {
    Session.set("timer",false);
    Meteor.clearInterval(id);
  }
});


