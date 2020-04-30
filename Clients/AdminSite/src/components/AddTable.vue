<template>
  <table>
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

img {
  width: 20px;
}

.image:hover {
  cursor: pointer;
}

.image {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  top: 0px;
  left: 1rem;
  width: 40px;
  height: 40px;
}
</style>
