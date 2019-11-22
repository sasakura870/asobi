document.addEventListener('DOMContentLoaded', function () {
  const capsule_toy = document.getElementsByClassName("js-capsule-toy");
  for (let index = 0; index < capsule_toy.length; index++) {
    console.log(capsule_toy[index]);
    capsule_toy[index].addEventListener('click', function () {
      Swal.fire({
        type: 'success',
        title: 'ガチャ',
        text: 'hogehoge'
      });
    });
  }
});
