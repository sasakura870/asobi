document.addEventListener('DOMContentLoaded', function () {
  const capsuleToy = document.getElementsByClassName("js-capsule-toy");
  for (let index = 0; index < capsuleToy.length; index++) {
    capsuleToy[index].addEventListener('click', async function () {
      const articleData = await fetch("/capsule_toys")
        .then(response => response.json())
        .catch(error => error);
      console.log(articleData);
      Swal.fire({
        text: articleData
      });
    });
  }
});
