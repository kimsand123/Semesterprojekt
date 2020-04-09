<template>
  <div class="site-wrapper">
    <VGrid variant="container">
      <VRow>
        <VCol variant="['md-12','sm-12','xs-12']">
          <h1>Welcome admin</h1>
        </VCol>
      </VRow>
    </VGrid>
  </div>
</template>

<script>
import FormField from './../FormField'

export default {
  name: 'LandingPage',
  components: {
    'FormField': FormField
  },
}
</script>

<style scoped>
.site-wrapper {
  position: absolute;
  top: 0;
  left: 0;
  display: flex;
  align-items: center;
  width: 100%;
  height: 100vh;
}
h1, h2 {
  font-weight: lighter;
}
</style>
