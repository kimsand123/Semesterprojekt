/****************************
***********MARKUP************
****************************/

<template>
    <VGrid variant="container">
      <VRow>
        <VCol>
          <MethodList :isGetActive="true" linkToGet="/games" linkToPost="/games/add"></MethodList>
        </VCol>
      </VRow>
      <VRow>
        <VCol :variants="['md-1', 'sm-1']">
          <Navigation :isGamesActive="true"></Navigation>
        </VCol>
        <VCol :variants="['md-10','sm-10']">
          <Modal ></Modal>
          <h1>Games</h1>
          <TableGames :titles="titles" :entries='entries' :handleDelete='handleDelete' :handleEdit="handleEdit"></TableGames>
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
import TableGames from './../../Tables/TableGames'
import { api_games, auth_header } from '../../../constants'
import { showModal } from '../../../service-utils'

let isEditMode = false
let originalTdData = []

export default {
  name: 'Games',
  components: {
    'Navigation': Navigation,
    'MethodList': MethodList,
    'Modal': Modal,
    'TableGames': TableGames
  },
  data: () => {
    return {
      titles: ['ID', 'Match Name', 'Question Duration', 'Question IDs', 'Player One ID', 'Player Two ID'],
      entries: []
    }
  },
  mounted() {
    this.$http.get(api_games, {
      headers: auth_header
    })
    .then(res => {
      if(res.status === 200) {
        res.data.games.forEach(game => {
          if(game.player_status !== undefined) {
            this.entries.push(game)
          }
        })
      }
    })
    .catch(error => {
      console.log(error)
    })
  },
  methods: {
    handleDelete(e) {
      const table = document.querySelector('table')
      const rowGameId = e.target.parentElement.parentElement.parentElement.children[0].innerText
      const rowIndex = e.target.parentElement.parentElement.parentElement.rowIndex
      const rows = e.target.parentElement.parentElement.parentElement.parentElement

      fetch(api_games+rowGameId+'/', {
        method: 'DELETE',
        headers: auth_header
      })
      .then(response => {
        if(response.status === 202) {
          table.deleteRow(rowIndex)
          showModal('Game deleted!')
        } else {
          showModal('Something went wrong...')
        }
      })
      .catch(error => {
        console.log('Error is', error)
      })
    },
    handleEdit(e) {
      isEditMode = !isEditMode
      const rowGamesId = e.target.parentElement.parentElement.parentElement.children[0].innerText
      const rowCells = e.target.parentElement.parentElement.parentElement.children
      const rowIndex = e.target.parentElement.parentElement.parentElement.rowIndex
      const rows = e.target.parentElement.parentElement.parentElement.parentElement.children
      const editIcon = document.querySelector('#edit-icon')

      if(isEditMode) {
        originalTdData = [rowGamesId]
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
        if(i >= 1 && i <= 2 && isEditMode) {
          rowCells[i].addEventListener('keypress', this.edit.bind(e, rowCells, originalTdData, rows, rowIndex))
          if(i >= 1 && i <= 2) {
            rowCells[i].innerHTML = "<input value='" + originalTdData[i] + "'>"
          }
        } else if(i < rowCells.length - 2) {
          rowCells[i].innerHTML = originalTdData[i]
        }
      }

      const inputFields = document.querySelectorAll('input')

      inputFields.forEach(field => {
        field.style.width = '80%'
        field.style.padding = '15px 5px'
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
        game: {
          match_name: newData[0],
          question_duration: newData[1]
        }
      })

      if (e.key === 'Enter') {
        let newDataIndex = 0
        fetch(api_games + originalTdData[0] + '/', {
          method: 'PUT',
          body: payload,
          headers: auth_header
        })
        .then(response => {
          if(response.status === 202) {
            for(let j = 1; j < rowCells.length - 5; j++) {
              rowCells[j].innerHTML = newData[newDataIndex]
              newDataIndex++
            }
            showModal('Game changed!')
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

/*************************
*********STYLING**********
*************************/

<style scoped>
li:not(:last-of-type)::after {
  content: ', '
}
</style>
