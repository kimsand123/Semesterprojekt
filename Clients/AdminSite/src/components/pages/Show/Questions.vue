<template>
  <div class="site-wrapper">
    <Modal></Modal>
    <Navigation :isQuestionsActive="true"></Navigation>
    <VGrid variant="container">
      <VRow>
        <VCol variant="['md-12','sm-12','xs-12']">
          <MethodList :isGetActive="true" linkToGet="/questions" linkToPost="/questions/add"></MethodList>
          <TableQuestions :titles="titles" :entries='entries' :handleDelete='handleDelete' :handleEdit="handleEdit"></TableQuestions>
        </VCol>
      </VRow>
    </VGrid>
  </div>
</template>

<script>
import Navigation from '../../Navigation'
import MethodList from '../../MethodList'
import TableQuestions from './../../Tables/TableQuestions'
import Modal from './../../Modal'
import { api_questions, auth_header } from '../../../constants'
import { showModal } from './../../../service-utils'

let isEditMode = false
let originalTdData = []

export default {
  name: 'Questions',
  components: {
    'Navigation': Navigation,
    'MethodList': MethodList,
    'Modal': Modal,
    'TableQuestions': TableQuestions
  },
  data: () => {
    return {
      titles: ['ID', 'Question', 'Correct Answer', 'Answer 1', 'Answer 2', 'Answer 3'],
      entries: []
    }
  },
  mounted() {
    this.$http.get(api_questions, {
      headers: auth_header
    })
    .then(res => {
      if(res.status === 200) {
        res.data.questions.forEach(question => {
          this.entries.push(question)
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
    handleDelete(e) {
      const table = document.querySelector('table')
      const rowQuestionId = e.target.parentElement.parentElement.parentElement.children[0].innerText
      const rowIndex = e.target.parentElement.parentElement.parentElement.rowIndex
      const rows = e.target.parentElement.parentElement.parentElement.parentElement

      fetch(api_questions+rowQuestionId+'/', {
        method: 'DELETE',
        headers: auth_header
      })
      .then(response => {
        if(response.status === 202) {
          table.deleteRow(rowIndex)
          showModal('Question deleted!')
        } else if(response.status !== 404) {
          showModal('Something went wrong...')
        }
      })
      .catch(error => {
        console.log('Error is', error)
      })
    },
    handleEdit(e) {
      isEditMode = !isEditMode
      const rowQuestionId = e.target.parentElement.parentElement.parentElement.children[0].innerText
      const rowCells = e.target.parentElement.parentElement.parentElement.children
      const rowIndex = e.target.parentElement.parentElement.parentElement.rowIndex
      const rows = e.target.parentElement.parentElement.parentElement.parentElement.children
      const editIcon = document.querySelector('#edit-icon')
      const formField = document.createElement("input")


      if(isEditMode) {
        originalTdData = [rowQuestionId]
        for(let i = 1; i < rowCells.length; i++) {
          originalTdData.push(rowCells[i].innerHTML)
        }
        for(let i = 0; i < rows.length; i++) {
          if(rowIndex !== i && i !== 0) {
            rows[i].children[rowCells.length - 2].children[0].style.pointerEvents = "none"
            rows[i].children[rowCells.length - 2].children[0].children[0].style.pointerEvents = "none"
          }
        }
      } else {
        for(let i = 0; i < rows.length; i++) {
          if(rowIndex !== i && i !== 0) {
            rows[i].children[rowCells.length - 2].children[0].style.pointerEvents = "all"
            rows[i].children[rowCells.length - 2].children[0].children[0].style.pointerEvents = "all"
          }
        }
      }
      

      for(let i = 0; i < rowCells.length; i++) {
        if(i < rowCells.length - 2 && i > 0 && isEditMode) {
          rowCells[i].addEventListener('keypress', this.edit.bind(e, rowCells, originalTdData, rows, rowIndex))
          if(i < rowCells.length - 2 && i > 0) {
            rowCells[i].innerHTML = "<input value='" + originalTdData[i] + "'>"
          }
        } else if(i < rowCells.length - 2) {
          rowCells[i].innerHTML = originalTdData[i]
        }
      }
    },
    edit(rowCells, originalTdData, rows, rowIndex, e) {
      const newData = []
      const inputFields = document.querySelectorAll('input')
      
      inputFields.forEach(field => {
        newData.push(field.value)
      })

      const payload = JSON.stringify({
        question: {
          question_text: newData[0],
          correct_answer: newData[1],
          answer_1: newData[2],
          answer_2: newData[3],
          answer_3: newData[4],
        }
      })

      if (e.key === 'Enter') {
        let newDataIndex = 0
          fetch(api_questions + originalTdData[0] + '/', {
            method: 'PUT',
            body: payload,
            headers: auth_header
          })
          .then(response => {
            if(response.status === 202) {
              for(let j = 1; j < rowCells.length - 2; j++) {
                rowCells[j].innerHTML = newData[newDataIndex]
                newDataIndex++
              }
              showModal('Question changed!')
              for(let i = 0; i < rows.length; i++) {
                if(rowIndex !== i && i !== 0) {
                  rows[i].children[rowCells.length - 2].children[0].style.pointerEvents = "all"
                  rows[i].children[rowCells.length - 2].children[0].children[0].style.pointerEvents = "all"
                }
              }
            } else (
              showModal('Something went wrong...')
            )
          })
        isEditMode = false
      }
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
