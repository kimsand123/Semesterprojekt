<template>
  <div class="site-wrapper">
    <Navigation></Navigation>
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
  name: 'HomePage',
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

ul {
  list-style-type: none;
  padding: 0;
  margin: 0;
  padding-left: 2rem;
  padding-bottom: 2rem;
}

li {
  display: inline-block;
  padding-right: 1rem;
}

img {
  width: 40px;
  height: 40px;
}

.banner {
  width: 5rem;
  height: 100%;
  position: absolute;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  z-index: 1;
  left: 0;
  top: 0;
  background: white;
}

.title {
  color: #00BD81;
}

.welcome {
  font-weight: 600;
  color: #00BD81;
}

.slash {
  color: white;
}

.logout {
  padding-bottom: 2rem;
}

a:hover {
  cursor: pointer;
}

a, router-link {
  text-decoration: none;
  color: #322C4A;
}
</style>
