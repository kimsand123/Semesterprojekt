<template>
  <div class="site-wrapper">
    <Modal ></Modal>
    <Navigation :isPlayersActive="true"></Navigation>
    <VGrid variant="container">
      <VRow>
        <VCol :variants="['md-12','sm-12','xs-12']">
          <MethodList :isGetActive="true" linkToGet="/players" linkToPost="/players/add" linkToPut="/players/edit" linkToDelete="/players/delete"></MethodList>
          <TablePlayers :titles="titles" :entries='entries' :handleDelete='handleDelete' :handleEdit="handleEdit"></TablePlayers>
        </VCol>
      </VRow>
    </VGrid>
  </div>
</template>

<script>
import Navigation from '../../Navigation'
import MethodList from '../../MethodList'
import TablePlayers from '../../tables/TablePlayers'
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
        console.log('test')
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
      const formField = document.createElement("input")

      if(isEditMode) {
        originalTdData = []
        for(const cell of rowCells) {
          originalTdData.push(cell.innerHTML)
        }
        // for(let i = 0; i < rows.length; i++) {
        //   if(rowIndex !== i) {        
        //     for(let i = 0; i < rowCells.length; i++) {
        //       if(i === rowCells.length - 2) {
        //         rowCells[i].children[0].children[0].style.pointerEvents = "none"
        //         rowCells[i].children[0].style.pointerEvents = "none"
        //       }
        //     }
        //   }
        // }
      }

      for(let i = 0; i < rowCells.length; i++) {
        if(i < rowCells.length - 2 && isEditMode) {
          rowCells[i].addEventListener('keypress', this.edit.bind(e, rowCells, originalTdData))
          if(i === 0 || i === rowCells.length - 2) {
            rowCells[i].innerHTML = "<input size='3' value='" + originalTdData[i] + "'>"
          } else {
            rowCells[i].innerHTML = "<input value='" + originalTdData[i] + "'>"
          }
        } else if(i < rowCells.length - 2) {
          rowCells[i].innerHTML = originalTdData[i]
        }
      }
    },
    edit(rowCells, originalTdData, e) {
      const newData = []
      const inputFields = document.querySelectorAll('input')
      
      inputFields.forEach(field => {
        newData.push(field.value)
      })

      const payload = JSON.stringify({
        player: {
          username: newData[4],
          email: newData[5],
          first_name: newData[1],
          last_name: newData[2],
          study_programme: newData[3],
          high_score: newData[6]
        }
      })

      if (e.key === 'Enter') {
        for(let j = 0; j < rowCells.length; j++) {
          if(j < rowCells.length - 2) {
            fetch(api_players + originalTdData[0] + '/', {
              method: 'PUT',
              body: payload,
              headers: auth_header
            })
            .then(response => {
              if(response.status === 202) {
                rowCells[j].innerHTML = newData[j]
              } else (
                showModal('Something went wrong...')
              )
            })
          }
        }
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
