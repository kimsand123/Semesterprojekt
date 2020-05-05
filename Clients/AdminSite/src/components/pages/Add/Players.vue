/****************************
***********MARKUP************
****************************/

<template>
    <VGrid variant="container">
      <VRow>
        <VCol>
          <MethodList :isPostActive="true" linkToGet="/players" linkToPost="/players/add"></MethodList>
        </VCol>
      </VRow>
      <VRow>
        <VCol :variants="['md-1', 'sm-1']">
          <Navigation :isPlayersActive="true"></Navigation>
        </VCol>
        <VCol :variants="['md-10','sm-10']">
          <Modal></Modal>
          <h1>Add User</h1>
          <AddTable
            :titles="titles"
            :numOfEntries="numOfEntries"
            :handleClick="handleClick">
          </AddTable>
        </VCol>
      </VRow>
    </VGrid>
</template>

/****************************
*********JAVASCRIPT**********
****************************/

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
  mounted() {
    document.querySelectorAll('input').forEach(field => {
      field.addEventListener('keypress', (e) => {
        if(e.key === 'Enter') {
          this.handleClick()
        }
      })
    })
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
      .catch(error => {
        showModal('Something went wrong....')
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
