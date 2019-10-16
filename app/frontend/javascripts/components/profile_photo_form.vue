<template>
  <div>
    <button @click="cropImage" type="button" class="btn btn-primary">切り抜き</button>
    <img
      :src="cropImg"
      style="width: 200px; height: 150px; border: 1px solid gray"
      alt="Cropped Image"
    />
    <div
      id="cropModal"
      class="modal"
      tabindex="-1"
      role="dialog"
      aria-labelledby="cropModalCenteredLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalCenteredLabel">Modal title</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div style="width: 200px; height:200px; border: 1px solid gray; display: inline-block;">
              <vue-cropper
                ref="cropper"
                :src="imgSrc"
                alt="ProfilePhoto"
                :img-style="{ 'width': '200px', 'height': '200px' }"
                :preview="hogehoge"
                :aspect-ratio="1"
              ></vue-cropper>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary">Save changes</button>
          </div>
        </div>
      </div>
    </div>
    <input
      @change="setImage"
      accept="image/jpeg, image/gif, image/png"
      type="file"
      data-toggle="modal"
      data-target="#cropModal"
    />
  </div>
</template>

<script>
import VueCropper from "vue-cropperjs";
import "cropperjs/dist/cropper.css";
export default {
  components: {
    VueCropper
  },
  data() {
    return {
      imgSrc: "",
      cropImg: ""
    };
  },
  methods: {
    setImage: function(event) {
      const file = event.target.files[0];
      if (!file.type.includes("image/")) {
        alert("画像のみ！");
        return;
      }

      const reader = new FileReader();
      reader.onload = event => {
        console.log("success");
        console.log(this.$refs);
        this.imgSrc = event.target.result;
        this.$refs.cropper.replace(event.target.result);
      };
      reader.onerror = event => {
        console.log("error");
        console.log(event);
      };
      reader.readAsDataURL(file);
    },
    cropImage: function(event) {
      this.cropImg = this.$refs.cropper.getCroppedCanvas().toDataURL();
    }
  }
};
</script>

<style>
</style>
