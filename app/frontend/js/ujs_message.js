import toast from "./mixins/toast";

document.addEventListener('DOMContentLoaded', function () {
  document.body.addEventListener("ajax:complete", function (event) {
    var data = JSON.parse(event.detail[0].response);
    toast.methods.toast(data.type, data.message);
  });
});
