export default {
  methods: {
    toast: function (type, message) {
      Swal.fire({
        type: type,
        title: message,
        toast: true,
        position: 'bottom-start',
        grow: 'column',
        showConfirmButton: false,
        showCloseButton: true
      });
    }
  }
}
