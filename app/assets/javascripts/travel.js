// $(document).ready(function() {
//     // google.maps.event.addDomListener(window, 'load', function(){initialize(53.350140, -6.266155);});
//     getVar(53.350140, -6.266155);
// });


// function getVar(lat, lng){
//   var map;
//   var infowindow;
//   var service ;
//   var origin = new google.maps.LatLng(lat,lng);
   
//     map = new google.maps.Map(document.getElementById('autocomplete'));
    
//     var request = {
//       location: origin,
//       radius: 2500,
//       types: ['bus_station']
//     };
//     infowindow = new google.maps.InfoWindow();
//     service = new google.maps.places.PlacesService(map);
//     service.search(request, callback);

//   function callback(results, status) {
//     console.log(results.length)
//     if (status == google.maps.places.PlacesServiceStatus.OK) {
//       for (var i = 0; i < results.length; i++) {
//         // console.log(results[i])
//       }
//     }
//   }
// }
