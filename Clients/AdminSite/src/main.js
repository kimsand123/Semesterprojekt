import Vue from 'vue'
import VueRouter from 'vue-router'
import VueAnime from 'vue-animejs'
import FlexboxgridVue from '@vivid-web/flexboxgrid-vue'
import App from './App'
import routes from './routes'
import axios from 'axios'
import VueAxios from 'vue-axios'
import AxiosPlugin from 'vue-axios-cors'
import VueCookies from 'vue-cookies'

Vue.use(AxiosPlugin)
Vue.use(VueAxios, axios)
Vue.use(FlexboxgridVue)
Vue.use(VueAnime)
Vue.use(VueRouter)
Vue.use(VueCookies)
Vue.config.productionTip = false

const router = new VueRouter({ routes })

Vue.$cookies.config('7d')
console.log(Vue.$cookies.get('user_session'))

router.beforeEach((to, from, next) => {
    const session_id = Vue.$cookies.get('user_session')

    if (session_id === null) next({ path: '/' })
    else next()
})

new Vue({
    render: h => h(App),
    router,
}).$mount('#app');