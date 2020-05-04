<template>
  <div class="site-wrapper">
    <Modal ></Modal>
    <Navigation :isGamesActive="true"></Navigation>
    <VGrid variant="container">
      <VRow>
        <VCol variant="['md-12','sm-12','xs-12']">
          <MethodList :isGetActive="true" linkToGet="/players" linkToPost="/players"></MethodList>
          <TableGames :titles="titles" :entries='entries' :handleDelete='handleDelete' :handleEdit="handleEdit"></TableGames>
        </VCol>
      </VRow>
    </VGrid>
  </div>
</template>

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
      titles: ['ID', 'Match Name', 'Question Duration', 'Question IDs', 'Player IDs' ],
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
          this.entries.push(game)
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
      const rowGamesId = e.target.parentElement.parentElement.parentElement.children[0].innerText
      const rowCells = e.target.parentElement.parentElement.parentElement.children
      const rowIndex = e.target.parentElement.parentElement.parentElement.rowIndex
      const rows = e.target.parentElement.parentElement.parentElement.parentElement.children
      const editIcon = document.querySelector('#edit-icon')
      let questionArray = []
      let playerArray = []

      if(isEditMode) {
        originalTdData = [rowGamesId]
        for(let i = 1; i < rowCells.length; i++) {
          if(i === 3) {
            console.log('UL ELEM', rowCells[i].children[0])
            questionArray = []
            const questionListItems = rowCells[i].children[0].children
            for(const li of questionListItems) {
              questionArray.push(li.innerHTML)
            }
            originalTdData.push(questionArray)
          } else if(i === 4) {
            playerArray = []
            const playerListItems = rowCells[i].children[0].children
            for(const li of playerListItems) {
              playerArray.push(li.innerHTML)
            }
            originalTdData.push(playerArray)
          } else {
            originalTdData.push(rowCells[i].innerHTML)
          }
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
          if(i === 3 || i === 4) {
            const list = document.createElement('ul')
            for (let j = 0; j < originalTdData[i].length; j++) {
              const item = document.createElement('li')
              item.setAttribute('style', 'display: inline;')
              item.appendChild(document.createTextNode(originalTdData[i][j]))
              list.appendChild(item)
            }

            rowCells[i].innerHTML = "<ul style='list-style-type:none;'>" + list.innerHTML + "</ul>"
          } else {
            rowCells[i].innerHTML = originalTdData[i]
          }
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
        fetch(api_games + originalTdData[0] + '/', {
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
