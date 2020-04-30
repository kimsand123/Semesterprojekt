<template>
  <table id="table">
    <tr>
      <th v-for="title in titles" :key="title">{{title}}</th>
    </tr>
    <tr v-for="entry in entries" :key="entry.id">
      <td>{{entry.id}}</td>
      <td>{{entry.first_name}}</td>
      <td>{{entry.last_name}}</td>
      <td>{{entry.study_programme}}</td>
      <td>{{entry.username}}</td>
      <td>{{entry.email}}</td>
      <td>{{entry.high_score}}</td>
    </tr>
  </table>
</template>

<script>
export default {
  name: 'Table',
  props: {
    titles: Array,
    entries: Array
  }
}
</script>

<style scoped>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: rgba(0, 189, 129, 0.2);
}

img {
  width: 15px;
  float: right;
}
</style>
