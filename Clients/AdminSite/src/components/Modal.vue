<template>
  <div class="modal">
    <h3 class="modal-title"></h3>
  </div>
</template>

<script>
export default {
  name: 'Modal',
}
</script>

<style scoped>
.modal {
  position: absolute;
  left: 50%;
  top: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transform: translate(-50%, -50%);
  z-index: 9999;
  width: 15%;
  height: 5%;
  background: #FBF7FF;
  border-radius: 20px;
  box-shadow: 5px 5px 15px 0px rgba(0,0,0,0.4);
  transition: 0.5s;
  padding: 0px 20px;
}

h3 {
  font-size: 16px;
}
</style>
