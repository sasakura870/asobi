window.addEventListener('load', function () {
  const type = document.getElementById("toast_type").value;
  const message = document.getElementById("toast_message").value;
  Swal.fire({
    type: type,
    title: message,
    toast: true,
    position: 'bottom-start',
    showConfirmButton: false,
    showCloseButton: true
  });
});
