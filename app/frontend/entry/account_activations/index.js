document.addEventListener("DOMContentLoaded", function () {
  document.body.addEventListener("ajax:complete", function (event) {
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
