<template>
  <div class="site-wrapper">
    <Navigation :isPlayersActive="true"></Navigation>
    <VGrid variant="container">
      <VRow>
        <VCol :variants="['md-12','sm-12','xs-12']">
          <MethodList :isPostActive="true" linkToGet="/players" linkToPost="/players/add" linkToPut="/players/edit" linkToDelete="/players/delete"></MethodList>
          <AddTable
            :titles="titles"
            :numOfEntries="numOfEntries"
            :handleClick="handleClick">
          </AddTable>
        </VCol>
      </VRow>
    </VGrid>
  </div>
</template>

<script>
import Navigation from '../../Navigation'
import MethodList from '../../MethodList'
import AddTable from '../../AddTable'
import { api_players, auth_header} from '../../../constants'

export default {
  name: 'PlayersAdd',
  components: {
    'Navigation': Navigation,
    'MethodList': MethodList,
    'AddTable': AddTable
  },
  methods: {
    handleClick() {
      const fields = document.querySelectorAll('input')
      const input = []

      fields.forEach(field => {
        input.push(field.value)
      })

     const payload = {
          "player": {
            "username": "e",
            "email": "s123456@studen.le.dk",
            "first_name": "Ll",
            "last_name": "Lelsn",
            "study_programme": "Software technology",
            "high_score": 20.1
          }
      }

      console.log('RAW', payload)

      this.$http.post(api_players, payload, auth_header)
      .then(response => {
        console.log(response.data)
      })
      .catch(error => {
        console.log(error)
      })
    }
  },
  data: () => {
    return {
      titles: ['First Name', 'Last Name', 'Study Programme', 'Username', 'Email', 'High Score'],
      numOfEntries: 6
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
