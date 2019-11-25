import toast from "./mixins/toast";

document.addEventListener('DOMContentLoaded', function () {
  const type = document.getElementById("toast_type");
  const message = document.getElementById("toast_message");
  if (type && message) {
    toast.methods.toast(type.value, message.value);
  }
});
