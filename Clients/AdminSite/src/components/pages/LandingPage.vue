/****************************
***********MARKUP************
****************************/

<template>
  <div class="site-wrapper">
    <VGrid variant="container">
      <VRow>
        <VCol :variants="['md-12','sm-12','xs-12']">
          <div class="form-field-wrapper">
            <h1>GolfQuiz Admin Login</h1>
            <form method="post" @submit.prevent="login">
              <FormField type="text" placeholder="admin" label_id="username"/>
              <FormField type="password" placeholder="*******" label_id="password"/>
              <input id="login-button" type="submit" value="Login"/>
            </form>
          </div>
        </VCol>
      </VRow>
    </VGrid>
  </div>
</template>

/****************************
*********JAVASCRIPT**********
****************************/

<script>
import FormField from './../FormField'

export default {
  name: 'LandingPage',
  components: {
    'FormField': FormField
  },
  mounted() {
    const passwordField = document.querySelector('#password')
    const loginButton = document.querySelector('#login-button')

    this.$cookies.remove('user_session')

    passwordField.addEventListener('keyup', (event) => {
      if(event.keyCode === 13) {
        loginButton.click()
      }
    })
  },
  methods: {
    login: function() {
      const usernameField = document.querySelector('#username')
      const passwordField = document.querySelector('#password')

      if(usernameField.value === "admin" && passwordField.value === "password") {
        this.$router.push({path: "/players", query: {name: usernameField.value}})
        this.$cookies.set("user_session", "25j_7Sl6xDq2Kc3ym0fmrSSk2xV2XkUkX", '1d')
      } else {
        alert('Username or password was incorrect')
      }
    }
  }
}
</script>

/*************************
*********STYLING**********
*************************/

<style scoped>
.site-wrapper {
  background:#00BD81;
  position: absolute;
  top: 0;
  left: 0;
  display: flex;
  align-items: center;
  width: 100%;
  height: 100vh;
}

#login-button {
  width: 60%;
  height: 2rem;
  border-radius: 8px;
  background-color: #00BD81;
  color: white;
  border: none;
}

#login-button:hover {
  cursor: pointer;
}

.form-field-wrapper {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: white;
  padding: 2rem;
  border-radius: 20px;
  box-shadow: 5px 5px 10px 0px rgba(0,0,0,0.75);
}

h1, h2, p {
  font-weight: lighter;
}
</style>
