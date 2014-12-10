var moment = require('moment');


Parse.Cloud.job("createEventDateObject", function(request, status) {
	Parse.Cloud.useMasterKey();
	var _ = require('underscore');

	var kTTEventKey = "EventsPricePoints";
	var kTTEventDateKey = "EventDate";
	var kTTEventTimeKey = "EventTime";
	var kTTEventDateObjectKey = "EventDateObject";

	var Event = Parse.Object.extend(kTTEventKey);

	var eventWithoutDateObjectQuery = new Parse.Query(kTTEventKey);
	eventWithoutDateObjectQuery.doesNotExist(kTTEventDateObjectKey)
	eventWithoutDateObjectQuery.limit(1000);

	eventWithoutDateObjectQuery.find().then(function(results) {
	    // Create a trivial resolved promise as a base case.
		var promise = Parse.Promise.as();
	    _.each(results, function(result) {
	      // For each item, extend the promise with a function to delete it.
	      promise = promise.then(function() {
	        // Return a promise that will be resolved when the delete is finished.
	        var m = moment(result.get(kTTEventDateKey)+" "+result.get(kTTEventTimeKey), "YYYY-MM-DD HH:mm:ss")
	        var date = m.toDate()
	        console.log("date object "+date)
	        result.set(kTTEventDateObjectKey, date);
	        return result.save()
	    });
	  });
	    return promise;

	}).then(function() {
		status.success();
	});
});
