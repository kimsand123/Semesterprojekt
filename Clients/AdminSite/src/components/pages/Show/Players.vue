/****************************
***********MARKUP************
****************************/

<template>
    <VGrid :variants="['container']">
      <VRow>
        <VCol>
          <MethodList :isGetActive="true" linkToGet="/players" linkToPost="/players/add"></MethodList>
        </VCol>
      </VRow>
      <VRow>
        <VCol :variants="['md-1', 'sm-1']">
          <Navigation :isPlayersActive="true"></Navigation>
        </VCol>
        <VCol :variants="['md-10','sm-10']">
          <Modal ></Modal>
          <h1>Users</h1>
          <TablePlayers :titles="titles" :entries='entries' :handleDelete='handleDelete' :handleEdit="handleEdit"></TablePlayers>
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
import TablePlayers from '../../Tables/TablePlayers'
import Modal from '../../Modal'
import { api_players, auth_header} from '../../../constants'
import { showModal } from './../../../service-utils'

let isEditMode = false
let originalTdData = []

export default {
  name: 'Players',
  components: {
    'Navigation': Navigation,
    'MethodList': MethodList,
    'TablePlayers': TablePlayers,
    'Modal': Modal
  },
  data: () => {
    return {
      titles: ['ID', 'First Name', 'Last Name', 'Study Programme', 'Username', 'Email', 'High Score'],
      entries: []
    }
  },
  mounted() {
    this.$http.get(api_players, {
      headers: auth_header
    })
    .then(res => {
      if(res.status === 200) {
        res.data.players.forEach(player => {
          this.entries.push(player)
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
      const rowPlayerId = e.target.parentElement.parentElement.parentElement.children[0].innerText
      const rowIndex = e.target.parentElement.parentElement.parentElement.rowIndex
      const rows = e.target.parentElement.parentElement.parentElement.parentElement

      fetch(api_players+rowPlayerId+'/', {
        method: 'DELETE',
        headers: auth_header
      })
      .then(response => {
        if(response.status === 202) {
          table.deleteRow(rowIndex)
          showModal('Player deleted!')
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
      const rowPlayerId = e.target.parentElement.parentElement.parentElement.children[0].innerText
      const rowCells = e.target.parentElement.parentElement.parentElement.children
      const rowIndex = e.target.parentElement.parentElement.parentElement.rowIndex
      const rows = e.target.parentElement.parentElement.parentElement.parentElement.children
      const editIcon = document.querySelector('#edit-icon')

      if(isEditMode) {
        originalTdData = [rowPlayerId]
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

      const inputFields = document.querySelectorAll('input')

      inputFields.forEach(field => {
        field.style.width = '80%'
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
        player: {
          username: newData[3],
          email: newData[4],
          first_name: newData[0],
          last_name: newData[1],
          study_programme: newData[2],
          high_score: newData[5]
        }
      })

      if (e.key === 'Enter') {
        let newDataIndex = 0
        fetch(api_players + originalTdData[0] + '/', {
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
            showModal('Player changed!')
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
