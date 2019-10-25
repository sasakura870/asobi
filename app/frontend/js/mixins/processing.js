export default {
  data: function () {
    return {
      processing: false
    }
  },
  computed: {
    isProcessing: function () {
      return this.processing;
    }
  },
  methods: {
    startProcessing: function () {
      this.processing = true;
    },
    endProcessing: function () {
      this.processing = false;
    }
  }
}
