<template>
<div>
  <div class="scrollable-table">
    <table id="table">
      <tr>
        <th v-for="title in titles" :key="title">{{title}}</th>
      </tr>
      <tr>
        <td v-for="n in numOfEntries" :key="n">
          <FormField class="form" :label_id="n"></FormField>
        </td>
        <div @click="handleClick" class="image">
          <img src="./../assets/add.svg"/>
        </div>
      </tr>
    </table>
  </div>
</div>
</template>

<script>
import FormField from './FormField'

export default {
  name: 'AddTable',
  components: {
    'FormField': FormField
  },
  props: {
    titles: Array,
    numOfEntries: Number,
    handleClick: Function
  },
}
</script>

<style scoped>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

td {
  padding: 8px;
  border: 1px solid #dddddd;
}

img {
  position: relative;
  top: 15px;
  left: 25px;
  width: 20px;
}

.image:hover {
  cursor: pointer;
}

.scrollable-table {
  margin-top: 50px;
  height: 8rem;
  width: 100%;
	padding-right:50em;
	overflow: auto;
}´

.image {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  top: 10px;
  left: 1rem;
  width: 40px;
  height: 40px;
}
</style>
