/****************************
***********MARKUP************
****************************/

<template>
  <div class="site-wrapper">
    <Modal></Modal>
    <Navigation :isInviActive="true"></Navigation>
    <VGrid variant="container">
      <VRow>
        <VCol :variants="['md-12','sm-12','xs-12']">
          <MethodList :isPostActive="true" linkToGet="/invitations" linkToPost="/invitations/add"></MethodList>
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


/****************************
*********JAVASCRIPT**********
****************************/


<script>
import Navigation from '../../Navigation'
import MethodList from '../../MethodList'
import AddTable from '../../AddTable'
import Modal from '../../Modal'
import { auth_header, api_invites} from '../../../constants'
import { showModal } from './../../../service-utils'

export default {
  name: 'InvitationsAdd',
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
          invite: {
            sender_player_id: input[0],
            receiver_player_id: input[1],
            match_name: input[2],
            question_duration: input[3],
            accepted: false,
          }
      })

      fetch(api_invites, {
        method: 'POST',
        body: payload,
        headers: auth_header
      })
      .then(response => {
        if(response.status === 201) {
          showModal('Invite successfully added!')
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
      titles: ['Sender Player ID', 'Receiver Player ID', 'Match Name', 'Question Duration'],
      numOfEntries: 4
    }
  }
}
</script>


/*************************
*********STYLING**********
*************************/


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
