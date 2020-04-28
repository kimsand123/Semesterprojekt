<template>
  <div class="site-wrapper">
    <Navigation :isPlayersActive="true"></Navigation>
    <VGrid variant="container">
      <VRow>
        <VCol :variants="['md-12','sm-12','xs-12']">
          <MethodList :isDeleteActive="true" linkToGet="/players" linkToPost="/players/add" linkToPut="/players/edit" linkToDelete="/players/delete"></MethodList>
        </VCol>
      </VRow>
    </VGrid>
  </div>
</template>

<script>
import Navigation from '../../Navigation'
import MethodList from '../../MethodList'
import { api_players, auth_header} from '../../../constants'

export default {
  name: 'PlayersDelete',
  components: {
    'Navigation': Navigation,
    'MethodList': MethodList
  },
  mounted() {

    this.$http.get(api_players, auth_header)
      .then(res => {
        console.log(res.data.players)
      })
      .catch(error => {
        console.log(error)
      })
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
