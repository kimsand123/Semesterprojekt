import Vue from 'vue'
import VueRouter from 'vue-router'
import VueAnime from 'vue-animejs'
import FlexboxgridVue from '@vivid-web/flexboxgrid-vue'
import App from './App'
import routes from './routes'
import axios from 'axios'
import VueAxios from 'vue-axios'
import AxiosPlugin from 'vue-axios-cors'

Vue.use(AxiosPlugin)
Vue.use(VueAxios, axios)
Vue.use(FlexboxgridVue)
Vue.use(VueAnime)
Vue.use(VueRouter)
Vue.config.productionTip = false

const router = new VueRouter({ routes })

new Vue({
    render: h => h(App),
    router,
}).$mount('#app');