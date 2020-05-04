<template>
  <div class="site-wrapper">
    <Modal ></Modal>
    <Navigation :isGamesActive="true"></Navigation>
    <VGrid variant="container">
      <VRow>
        <VCol variant="['md-12','sm-12','xs-12']">
          <MethodList :isGetActive="true" linkToGet="/players" linkToPost="/players"></MethodList>
          <TableGames :titles="titles" :entries='entries' :handleDelete='handleDelete' :handleEdit="handleEdit"></TableGames>
        </VCol>
      </VRow>
    </VGrid>
  </div>
</template>

<script>
import Navigation from '../../Navigation'
import MethodList from '../../MethodList'
import Modal from './../../Modal'
import TableGames from './../../Tables/TableGames'
import { api_games, auth_header } from '../../../constants'

export default {
  name: 'Games',
  components: {
    'Navigation': Navigation,
    'MethodList': MethodList,
    'Modal': Modal,
    'TableGames': TableGames
  },
  data: () => {
    return {
      titles: ['ID', 'Match Name', 'Question Duration', 'Question IDs', 'Player IDs' ],
      entries: []
    }
  },
  mounted() {
    this.$http.get(api_games, {
      headers: auth_header
    })
    .then(res => {
      if(res.status === 200) {
        res.data.games.forEach(game => {
          this.entries.push(game)
        })
      } else {
        throw new Error('Something went wrong')
      }
    })
    .catch(error => {
      console.log(error)
    })
  },
  methods: {
    handleDelete() {
      console.log('Delete')
    },
    handleEdit() {
      console.log('Edit')
    }
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
