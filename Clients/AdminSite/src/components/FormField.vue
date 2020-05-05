<template>
  <div class="form-field">
    <input :type="type" :id="label_id" :name="label_id" :placeholder="placeholder" required>
  </div>
</template>

<script>
export default {
  name: 'FormField',
  props: {
    placeholder: String,
    label_id: [String, Number, Object],
    type: String
  }
}
</script>

<style scoped>
input {
  position: relative;
  margin-bottom: 1rem;
  background: rgb(230, 230, 230);
  border: none;
  width: 70%;
  padding: 0.5rem 1rem;
}
</style>
