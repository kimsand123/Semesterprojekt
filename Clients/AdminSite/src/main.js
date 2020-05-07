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

router.beforeEach((to, from, next) => {
    if (to.path !== '/') {
        if (Vue.$cookies.isKey('user_session')) {
            next()
        } else {
            next({ path: '/' })
        }
    } else {
        next()
    }
})

new Vue({
    render: h => h(App),
    router,
}).$mount('#app');
