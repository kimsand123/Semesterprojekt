/****************************
***********MARKUP************
****************************/

<template>
    <VGrid variant="container">
      <VRow>
        <VCol>
          <MethodList :isPostActive="true" linkToGet="/games" linkToPost="/games/add"></MethodList>
        </VCol>
      </VRow>
      <VRow>
        <VCol :variants="['md-1', 'sm-1']">
          <Navigation :isGamesActive="true"></Navigation>
        </VCol>
        <VCol :variants="['md-10','sm-10']">
          <Modal></Modal>
          <h1>Add Game</h1>
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
