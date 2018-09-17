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
  var distance = $(this).attr("data-distance");
  var modalBody = $(".modal-body")
  modalBody.html("")
  modalBody.html(I18n.t("web.calc_dist_from_location", {dist: distance}) );
  $("#myModal").modal('show');
})

$(document).on('click', '.upload-csv-btn', function(event){
  $(".add-file").remove();
  if($('#file').val() == ""){
    var error_msg = '<p class = "add-file"> ' + I18n.t("web.add_file") + '</p>';
    $('#file').after(error_msg)
    return false
  }
})


$( document ).on('turbolinks:load', function() {
  $('#myModal').on('click', '.modal-body #create-pokmn',  function() {
    $("#new_pokemon").validate({
      rules: {
        "pokemon[name]": {
          required: true,
          maxlength: 30
        },
        "pokemon[height]": {
          required: true,
          maxlength: 10
        },
        "pokemon[weight]":{
          required: true
        }
      },
      messages: {
        "pokemon[name]": {
            required:  I18n.t("web.enter_val", {val: I18n.t("model.pokemon.name")})
        },
        "pokemon[height]": {
            required:  I18n.t("web.enter_val", {val: I18n.t("model.pokemon.height")}),
            maxlength: I18n.t("web.character_validation", {val: I18n.t("model.pokemon.height"), num: 10})
        },
        "pokemon[weight]": {
            required:  I18n.t("web.enter_val", {val: I18n.t("model.pokemon.weight")})
        }
      }
    });
  });
})


