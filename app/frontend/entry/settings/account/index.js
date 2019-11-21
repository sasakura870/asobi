import RememberButton from "../../../js/components/remember_button";

document.addEventListener("DOMContentLoaded", function () {
  new vue({
    el: "#container",
    components: {
      "remember-button": RememberButton
    }
  })

  document.body.addEventListener("ajax:complete", function (event) {
    console.log(event.detail[0].response);
    var data = JSON.parse(event.detail[0].response);
    Swal.fire({
      type: data.type,
      title: data.message,
      toast: true,
      position: 'bottom-start',
      grow: 'column',
      showConfirmButton: false,
      showCloseButton: true
    });
  });
});
