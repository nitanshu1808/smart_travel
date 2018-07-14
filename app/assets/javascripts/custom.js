$(document).on('turbolinks:load', function() {
  $("#new_user").validate({
    rules: {
      "user[user_name]": {
        required: true,
        maxlength: 30
      },
      "user[email]": {
        required: true,
        maxlength: 50,
        email: true
      },
      "user[password]":{
        required: true
      }
    },
    messages: {
      "user[user_name]": {
          required:  I18n.t("model.user.enter_val", {val: I18n.t("model.user.user_name")})
      },
      "user[email]": {
          required:  I18n.t("model.user.enter_val", {val: I18n.t("model.user.email")}),
          maxlength: I18n.t("model.user.character_validation", {val: I18n.t("model.user.email"), num: 50}),
          email:     I18n.t("model.user.valid_email")
      },
      "user[password]": {
          required:  I18n.t("model.user.enter_val", {val: I18n.t("model.user.password")})
      }
    }
  });
});

$(document).on('click', '.stop-info', function(event){
  var self = $(this);
  var Id        = self.attr("href")
  var stopID    = Id.split('#')[1]
  var detailDiv = $(Id);

  var data = {
    "name": self.attr('data-stop-name'),
    "id": stopID
  }

  var onDone = function (result) {
    var div        = detailDiv.find(".panel-body")
    div.removeClass("hide")
    div.html("")
    if(result.is_valid){
      var dataSet       = result.data;
      var htmlString    = "<ul class='list-group'>"
      for (i = 0; i < dataSet.length; i++) {
        var data      = dataSet[i];        
        htmlString    += "<li class='list-group-item'><span class = 'bus-detail'>Due time: <b>" +                data.duetime + "</b></span>"  +
                          "<span class = 'bus-detail'>Destination: <b>" + data.destination + "</b></span>" +
                          "<span class = 'bus-detail'>Origin: <b>" + data.origin + "</b></span>" +
                          "<span class = 'bus-detail'>Arrival Time: <b>" + data.scheduledarrivaldatetime + "</b></span>" +
                          "<span class = 'bus-detail'>Departure Time: <b>" + data.scheduleddeparturedatetime + "</b></span>" +
                          "<span class = 'bus-detail'>Route No: <b>" + data.route + "</b></span>"
      }
      htmlString += "</li></ul>"
    }else{
      var htmlString = "<div class = 'text-center'>" + result.data + "</div>"
    }
    div.append(htmlString);
  }

  var onFail = function( err ) {
    console.log( "Error --> ", err );
  }

  ajaxCall('get', 'bus_stop', data, onDone, onFail, 'json');
})

function ajaxCall ( mType, url, dataObj,doneCB, failCB, dataType) {
  var ajaxObj = {
    method: mType,
    url: url,
    data: dataObj,
    dataType: 'json'
  }

  $.ajax(ajaxObj)
  .done(doneCB)
  .fail(failCB);
}

$(function() {
  setTimeout(function(){
    $('.flash-msg').slideUp(800);
  }, 1500);
});

$(document).on('click', '.calc-dist-btn', function(event){
  var self  = $(this);
  var id    = self.attr("id")
  var data = {
    "location": self.attr("data-location")
  }

  var onDone = function (result) {
    var modalBody = $(".modal-body")
    modalBody.html("")
    modalBody.html(result.distance);
    $("#myModal").modal('show');
  }

  var onFail = function( err ) {
    console.log( "Error --> ", err );
  }

  ajaxCall('get', 'calculate_distance', data, onDone, onFail, 'json');
})