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
  var Id = self.attr("href")
  var detailDiv = $(Id);

  var data = {
    "name": self.attr('data-stop-name')
  }

  var onDone = function (result) {
    var div = detailDiv.closest(".panel-body")
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
