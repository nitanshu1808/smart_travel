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
      }
      // "student[password]":{
      //   required: true
      // }
    },
    messages: {
      "user[user_name]": {
          required:  I18n.t("model.user.enter_val", {val: I18n.t("model.user.user_name")})
      },
      "user[email]": {
          required:  I18n.t("model.user.enter_val", {val: I18n.t("model.user.email")}),
          maxlength: I18n.t("model.user.character_validation", {val: I18n.t("model.user.email"), num: 50}),
          email:     I18n.t("model.user.valid_email")
      }
      // "student[password]": {
      //     required:  I18n.t("model.student.enter_val", {val: I18n.t("model.student.internship_company")})
      // }
    }
  });
});