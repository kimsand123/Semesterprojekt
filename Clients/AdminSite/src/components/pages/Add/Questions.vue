<template>
  <div class="site-wrapper">
    <Modal></Modal>
    <Navigation :isQuestionsActive="true"></Navigation>
    <VGrid variant="container">
      <VRow>
        <VCol :variants="['md-12','sm-12','xs-12']">
          <MethodList :isPostActive="true" linkToGet="/questions" linkToPost="/questions/add"></MethodList>
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
