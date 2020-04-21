<template>
  <div class="site-wrapper">
    <VGrid variant="container">
      <VRow>
        <VCol variant="['md-12','sm-12','xs-12']">
          <div class="form-field-wrapper">
            <h1>GolfQuiz Admin Login</h1>
            <form method="post" @submit.prevent="login">
              <FormField type="text" placeholder="s170000" label_id="username"/>
              <FormField type="password" placeholder="*******" label_id="password"/>
              <input id="login-button" type="submit" value="Login"/>
            </form>
          </div>
        </VCol>
      </VRow>
    </VGrid>
  </div>
</template>

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

      if(usernameField.value === "s170423" && passwordField.value === "test") {
        this.$router.push({path: "/homepage", query: {name: usernameField.value}})
      } else {
        alert('Username or password was incorrect')
      }
    }
  }
}
</script>

<style scoped>
.site-wrapper {
  background: rgb(2,0,36);
  background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(105,247,99,1) 0%, rgba(52,138,52,1) 100%);
  position: absolute;
  top: 0;
  left: 0;
  display: flex;
  align-items: center;
  width: 100%;
  height: 100vh;
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

h1, h2 {
  font-weight: lighter;
}
</style>
