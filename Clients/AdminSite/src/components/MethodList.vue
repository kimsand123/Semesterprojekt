<template>
  <div class="methods">
    <nav class="list">
        <li v-if="isGetActive"><router-link class="active" :to="linkToGet"><div class="bar"/>Show</router-link></li>
        <li v-else><router-link :to="linkToGet">Show</router-link></li>
        <li v-if="isPostActive"><router-link class="active" :to="{path: ''+linkToPost}"><div class="bar add"/>Add</router-link></li>
        <li v-else><router-link :to="linkToPost">Add</router-link></li>
    </nav>
  </div>
</template>

<script>
export default {
  name: 'MethodList',
  props: {
    isGetActive: Boolean,
    isPostActive: Boolean,
    isPutActive: Boolean,
    isDeleteActive: Boolean,
    linkToGet: String,
    linkToPost: String,
    linkToPut: String,
    linkToDelete: String
  }
}
</script>

<style scoped>
ul {
  list-style-type: none;
  padding: 0;
  margin: 0;
  padding-left: 2rem;
  padding-bottom: 2rem;
}

li {
  display: inline-block;
  padding-right: 2rem;
}

.bar {
  position: absolute;
  z-index: -1;
  display: block;
  left: -7.5px;
  top: 27.5px;
  height: 1.5rem;
  width: 3.5rem;
  border-radius: 16px;
  background: #00BD81;
}

.bar.add {
  left: 3.7rem;
}

.bar.edit {
  left: 7.45rem;
}

.bar.delete {
  left: 11.7rem;
}

.list {
  width: 5rem;
  height: 5rem;
  position: absolute;
  display: flex;
  flex-direction: row;
  align-items: center;
  z-index: 1;
  left: 150px;
  top: 0;
}

.slash {
  color: white;
}

.logout {
  padding-bottom: 2rem;
}

a:hover {
  cursor: pointer;
}

a, router-link {
  text-decoration: none;
  color: #AAAABC;
}

.active {
  color: white;
}
</style>
