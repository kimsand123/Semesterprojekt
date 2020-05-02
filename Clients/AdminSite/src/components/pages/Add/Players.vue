<template>
  <div class="site-wrapper">
    <Modal></Modal>
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
import Modal from '../../Modal'
import { api_players, auth_header, token} from '../../../constants'
import { showModal } from './../../../service-utils'

export default {
  name: 'PlayersAdd',
  components: {
    'Navigation': Navigation,
    'MethodList': MethodList,
    'AddTable': AddTable,
    'Modal': Modal
  },
  methods: {
    handleClick() {
      const fields = document.querySelectorAll('input')
      const input = []

      fields.forEach(field => {
        input.push(field.value)
      })

      let payload = JSON.stringify({
          player: {
            username: input[3],
            email: input[4],
            first_name: input[0],
            last_name: input[1],
            study_programme: input[2],
            high_score: input[5]
          }
      })

      fetch(api_players, {
        method: 'POST',
        body: payload,
        headers: auth_header
      })
      .then(response => {
        if(response.status === 201) {
          showModal('Player successfully added!')
          fields.forEach(field => {
            field.value = ''
          })
        } else {
          showModal('Something went wrong...')
        }
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
