<template>
  <div class="site-wrapper">
    <Navigation isQuestionsActive="true"></Navigation>
    <VGrid variant="container">
      <VRow>
        <VCol variant="['md-12','sm-12','xs-12']">

        </VCol>
      </VRow>
    </VGrid>
  </div>
</template>

<script>
import Navigation from '../Navigation'
export default {
  name: 'Questions',
  components: {
    'Navigation': Navigation
  }
}
</script>

<style scoped>
.site-wrapper {
  user-select: none;
  position: absolute;
  top: 0;
  left: 0;
  display: flex;
  align-items: center;
  width: 100%;
  height: 100vh;
  background: #FBF7FF;
}
</style>
