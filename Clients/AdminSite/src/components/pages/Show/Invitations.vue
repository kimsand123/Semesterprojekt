/****************************
***********MARKUP************
****************************/

<template>
    <VGrid variant="container">
      <VRow variant='md-center'>
        <VCol :variants="['md-offset-1','sm-offset-1','xs-offset-1']">
          <MethodList :isGetActive="true" linkToGet="/invitations" linkToPost="/invitations/add"></MethodList>
        </VCol>
      </VRow>
      <VRow>
        <VCol :variants="['md-1', 'sm-1', 'xs-1']">
          <Navigation :isInviActive="true"></Navigation>
        </VCol>
        <VCol :variants="['md-10','sm-10','xs-10']">
          <Modal ></Modal>
          <h1>Invitations</h1>
          <TableInvites :titles="titles" :entries='entries' :handleDelete='handleDelete' :handleEdit="handleEdit"></TableInvites>
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
import Modal from './../../Modal'
import TableInvites from './../../Tables/TableInvites'
import { api_invites, auth_header } from '../../../constants'
import { showModal } from '../../../service-utils'

let isEditMode = false
let originalTdData = []

export default {
  name: 'Invitations',
  components: {
    'Navigation': Navigation,
    'MethodList': MethodList,
    'Modal': Modal,
    'TableInvites': TableInvites
  },
  data: () => {
    return {
      titles: ['ID', 'Sender Player', 'Receiver Player', 'Match Name', 'Question Duration', 'Invite Accepted'],
      entries: []
    }
  },
  mounted() {
    this.$http.get(api_invites, {
      headers: auth_header
    })
    .then(res => {
      if(res.status === 200) {
        res.data.invites.forEach(invite => {
          this.entries.push(invite)
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

      fetch(api_invites+rowQuestionId+'/', {
        method: 'DELETE',
        headers: auth_header
      })
      .then(response => {
        if(response.status === 202) {
          table.deleteRow(rowIndex)
          showModal('Invite deleted!')
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
      const rowInviteId = e.target.parentElement.parentElement.parentElement.children[0].innerText
      const rowCells = e.target.parentElement.parentElement.parentElement.children
      const rowIndex = e.target.parentElement.parentElement.parentElement.rowIndex
      const rows = e.target.parentElement.parentElement.parentElement.parentElement.children
      const editIcon = document.querySelector('#edit-icon')

      if(isEditMode) {
        originalTdData = [rowInviteId]
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
        if(i >= 3 && i <= 5 && isEditMode) {
          rowCells[i].addEventListener('keypress', this.edit.bind(e, rowCells, originalTdData, rows, rowIndex))
          if(i >= 3 && i <= 5) {
            rowCells[i].innerHTML = "<input value='" + originalTdData[i] + "'>"
          }
        } else if(i < rowCells.length - 2) {
          rowCells[i].innerHTML = originalTdData[i]
        }
      }

      const inputFields = document.querySelectorAll('input')

      inputFields.forEach(field => {
        field.style.width = '70%'
        field.style.padding = '5px 5px'
        field.style.borderRadius = '5px'
        field.style.border = '1px solid gray'
      })
    },
    edit(rowCells, originalTdData, rows, rowIndex, e) {
      const newData = []
      const inputFields = document.querySelectorAll('input')

      inputFields.forEach(field => {
        newData.push(field.value)
      })

      const payload = JSON.stringify({
        invite: {
          match_name: newData[0],
          question_duration: newData[1],
          accepted: newData[2] === 'true'
        }
      })

      if (e.key === 'Enter') {
        let newDataIndex = 0
        fetch(api_invites + originalTdData[0] + '/', {
          method: 'PUT',
          body: payload,
          headers: auth_header
        })
        .then(response => {
          if(response.status === 202) {
            for(let j = 3; j < rowCells.length - 2; j++) {
              rowCells[j].innerHTML = newData[newDataIndex]
              newDataIndex++
            }
            showModal('Invite changed!')
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
