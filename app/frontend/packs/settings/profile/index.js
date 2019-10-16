import VueCropper from 'vue-cropperjs';
import ProfilePhotoForm from '../../../javascripts/components/profile_photo_form';

document.addEventListener('DOMContentLoaded', function () {
  new vue({
    el: "#photo-form",
    components: {
      VueCropper,
      "profile-photo-form": ProfilePhotoForm
    },
    methods: {
      setImage: function (event) {
        console.log(event);
        console.log(this.$ref);
      }
    }
  })
});
