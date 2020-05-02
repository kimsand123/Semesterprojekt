<template>
  <div class="site-wrapper">
    <Navigation :isPlayersActive="true"></Navigation>
    <VGrid variant="container">
      <VRow>
        <VCol :variants="['md-12','sm-12','xs-12']">
          <MethodList :isGetActive="true" linkToGet="/players" linkToPost="/players/add" linkToPut="/players/edit" linkToDelete="/players/delete"></MethodList>
          <Table :titles="titles" :entries='entries'></Table>
        </VCol>
      </VRow>
    </VGrid>
  </div>
</template>

<script>
import Navigation from '../../Navigation'
import MethodList from '../../MethodList'
import Table from '../../Table'
import { api_players, auth_header} from '../../../constants'

export default {
  name: 'Players',
  components: {
    'Navigation': Navigation,
    'MethodList': MethodList,
    'Table': Table
  },
  data: () => {
    return {
      titles: ['ID', 'First Name', 'Last Name', 'Study Programme', 'Username', 'Email', 'High Score'],
      entries: []
    }
  },
  mounted() {
    this.$http.get(api_players, {
      headers: auth_header
    })
      .then(res => {
        res.data.players.forEach(player => {
          this.entries.push(player)
        })
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
