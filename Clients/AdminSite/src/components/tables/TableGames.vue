<template>
<div>
  <div class="scrollable-table">
    <table id="table">
      <tr>
        <th v-for="title in titles" :key="title">{{title}}</th>
      </tr>
      <tr v-for="entry in entries" :key="entry.id">
        <td>{{entry.id}}</td>
        <td>{{entry.match_name}}</td>
        <td>{{entry.question_duration}}</td>
        <td>
          <ul>
            <li v-for="entryQ in entry.questions" :key="entryQ.id">{{entryQ.id}}</li>
          </ul>
        </td>
        <td v-for="playerStat in entry.player_status" :key="playerStat.game_player.id">
          {{playerStat.game_player.player.id}}
        </td>
        <td>
          <div @click="handleEdit" class="icon">
            <img src="./../../assets/edit-tools.svg" id="edit-icon"/>
          </div>
        </td>
        <td>
          <div @click="handleDelete" class="icon">
            <img src="./../../assets/send-to-trash.svg"/>
          </div>
        </td>
      </tr>
    </table>
  </div>
</div>
</template>

<script>
export default {
  name: 'TableGames',
  props: {
    titles: Array,
    entries: Array,
    handleDelete: Function,
    handleEdit: Function
  }
}
</script>

<style scoped>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td:not(:last-child):not(:nth-last-child(2)), th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

td:nth-last-of-type(2) {
  background: #FBF7FF;
}

td:last-of-type {
  background: #FBF7FF;
}

tr:nth-child(even) {
  background-color: rgba(0, 189, 129, 0.2);
}

img {
  width: 15px;
  float: right;
  pointer-events: all;
}

.icon {
  pointer-events: none;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  top: 0px;
  left: 1rem;
  width: 20px;
  height: 20px;
}

.scrollable-table {
  margin-top: 50px;
  height: 35rem;
  width: 100%;
	padding: 0 15px;
	overflow: auto;
}

img:hover {
  cursor: pointer;
}

input {
  width: 100%;
}

ul {
  list-style-type: none;
}

li {
  display: inline;
}

li:not(:last-of-type)::after {
  content: ', '
}

</style>
