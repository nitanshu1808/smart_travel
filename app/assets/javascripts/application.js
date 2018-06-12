// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery-3.3.1.min
//= require_tree .




$(document).ready(function() {
    // google.maps.event.addDomListener(window, 'load', function(){initialize(53.350140, -6.266155);});
    getVar(53.350140, -6.266155);
});


function getVar(lat, lng){
  var map;
  var infowindow;
  var service ;
  var origin = new google.maps.LatLng(lat,lng);
   
    map = new google.maps.Map(document.getElementById('autocomplete'));
    
    var request = {
      location: origin,
      radius: 2500,
      types: ['bus_station']
    };
    infowindow = new google.maps.InfoWindow();
    service = new google.maps.places.PlacesService(map);
    service.search(request, callback);

  function callback(results, status) {
    console.log(results.length)
    if (status == google.maps.places.PlacesServiceStatus.OK) {
      for (var i = 0; i < results.length; i++) {
        // console.log(results[i])
      }
    }
  }
}
