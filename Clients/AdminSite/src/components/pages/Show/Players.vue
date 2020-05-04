<template>
  <div class="site-wrapper">
    <Modal ></Modal>
    <Navigation :isPlayersActive="true"></Navigation>
    <VGrid variant="container">
      <VRow>
        <VCol :variants="['md-12','sm-12','xs-12']">
          <MethodList :isGetActive="true" linkToGet="/players" linkToPost="/players/add" linkToPut="/players/edit" linkToDelete="/players/delete"></MethodList>
          <Table :titles="titles" :entries='entries' :handleDelete='handleDelete' :handleEdit="handleEdit"></Table>
        </VCol>
      </VRow>
    </VGrid>
  </div>
</template>

<script>
import Navigation from '../../Navigation'
import MethodList from '../../MethodList'
import Table from '../../Table'
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
    'Table': Table,
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
        res.data.players.forEach(player => {
          this.entries.push(player)
        })
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
    },
    handleEdit(e) {
      isEditMode = !isEditMode
      const rowPlayerId = e.target.parentElement.parentElement.parentElement.children[0].innerText
      const rowCells = e.target.parentElement.parentElement.parentElement.children
      const editIcon = document.querySelector('#edit-icon')
      const formField = document.createElement("input")

      if(isEditMode) {
        editIcon.setAttribute('src', './../../../assets/save.svg')
        originalTdData = []
        for(const cell of rowCells) {
          originalTdData.push(cell.innerHTML)
        }
      } else {
        editIcon.setAttribute('src', './../../../assets/save.svg')
      }

      for(let i = 0; i < rowCells.length; i++) {
        if(i < rowCells.length - 2 && isEditMode) {
          if(i === 0) {
            rowCells[i].innerHTML = "<input size='1' value='" + originalTdData[i] + "'>"
          } else {
            rowCells[i].innerHTML = "<input size='7' value='" + originalTdData[i] + "'>"
          }
        } else if(i < rowCells.length - 2) {
          rowCells[i].innerHTML = originalTdData[i]
        }
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
