/****************************
***********MARKUP************
****************************/

<template>
    <VGrid variant="container">
      <VRow>
        <VCol>
          <MethodList :isPostActive="true" linkToGet="/questions" linkToPost="/questions/add"></MethodList>
        </VCol>
      </VRow>
      <VRow>
        <VCol :variants="['md-1', 'sm-1']">
          <Navigation :isQuestionsActive="true"></Navigation>
        </VCol>
        <VCol :variants="['md-10','sm-10']">
          <Modal></Modal>
          <h1>Add Question</h1>
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
import { auth_header, api_questions} from '../../../constants'
import { showModal } from './../../../service-utils'

export default {
  name: 'QuestionsAdd',
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
          question: {
            question_text: input[0],
            correct_answer: input[1],
            answer_1: input[2],
            answer_2: input[3],
            answer_3: input[4],
          }
      })

      fetch(api_questions, {
        method: 'POST',
        body: payload,
        headers: auth_header
      })
      .then(response => {
        if(response.status === 201) {
          showModal('Question successfully added!')
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
      titles: ['Question', 'Correct Answer', 'Answer 1', 'Answer 2', 'Answer 3'],
      numOfEntries: 5
    }
  }
}
</script>
