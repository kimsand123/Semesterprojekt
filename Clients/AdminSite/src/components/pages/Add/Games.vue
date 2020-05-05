/****************************
***********MARKUP************
****************************/

<template>
  <div class="site-wrapper">
    <Modal></Modal>
    <Navigation :isGamesActive="true"></Navigation>
    <VGrid variant="container">
      <VRow>
        <VCol :variants="['md-12','sm-12','xs-12']">
          <MethodList :isPostActive="true" linkToGet="/games" linkToPost="/games/add"></MethodList>
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
import { auth_header, api_games} from '../../../constants'
import { showModal } from './../../../service-utils'

export default {
  name: 'GamesAdd',
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

      const questionInput = []
      input[2].split(',').forEach(input => {
        questionInput.push(parseInt(input))
      })

      let payload = JSON.stringify({
          game: {
            match_name: input[0],
            question_duration: input[1],
            questions: questionInput,
            player_status: [
              {
                game_player: {
                  player_id: input[3],
                  game_progress: 0,
                  score: 0
                },
                game_round: []
              },
              {
                game_player: {
                  player_id: input[4],
                  game_progress: 0,
                  score: 0
                },
                game_round: []
              }
            ]
          }
      })

      fetch(api_games, {
        method: 'POST',
        body: payload,
        headers: auth_header
      })
      .then(response => {
        if(response.status === 201) {
          showModal('Game successfully added!')
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
      titles: ['Match Name', 'Question Duration', 'Question IDs', 'Player One ID', 'Player Two ID'],
      numOfEntries: 5
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
