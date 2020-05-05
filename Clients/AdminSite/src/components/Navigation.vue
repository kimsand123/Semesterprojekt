<template>
  <div class="navigation">
    <nav class="banner">
      <div>
        <h1 class="title">GQ</h1>
      </div>
      <ul>
        <li v-if="isPlayersActive"><router-link to="/players"><div class="bar"/><img src="../assets/group_active.svg"></router-link></li>
        <li v-else><router-link to="/players"><img src="../assets/group.svg"></router-link></li>
        <li v-if="isGamesActive"><router-link to="/games"><div class="bar"/><img src="../assets/joystick_active.svg"></router-link></li>
        <li v-else><router-link to="/games"><img src="../assets/joystick.svg"></router-link></li>
        <li v-if="isQuestionsActive"><router-link to="/questions"><div class="bar"/><img src="../assets/question_active.svg"></router-link></li>
        <li v-else><router-link to="/questions"><img src="../assets/question.svg"></router-link></li>
        <li v-if="isInviActive"><router-link to="/invitations"><div class="bar"/><img src="../assets/invitation_active.svg"></router-link></li>
        <li v-else><router-link to="/invitations"><img src="../assets/invitation.svg"></router-link></li>
      </ul>
      <router-link class="logout" to="/"><img src="../assets/logout.svg"></router-link>
    </nav>
  </div>
</template>

<script>
export default {
  name: 'Navigation',
  props: {
    isPlayersActive: Boolean,
    isGamesActive: Boolean,
    isInviActive: Boolean,
    isQuestionsActive: Boolean
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
  padding-right: 1rem;
  margin-bottom: 4rem;
}

li:last-of-type {
  margin-left: -8px
}

img {
  width: 40px;
  height: 40px;
}

.bar {
  position: absolute;
  left:0;
  height: 40px;
  width: .3rem;
  background: #00BD81;
}

.banner {
  width: 5rem;
  height: 100%;
  position: absolute;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  z-index: 1;
  left: 0;
  top: 0;
  background: #FAF8FF;
  box-shadow: 5px 0 25px -5px rgba(0,0,0,0.15);
}

.title {
  color: #00BD81;
}

.logout {
  padding-bottom: 2rem;
}

a:hover {
  cursor: pointer;
}

a, router-link {
  text-decoration: none;
  color: #322C4A;
}
</style>
