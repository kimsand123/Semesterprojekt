import Vue from 'vue'
import VueRouter from 'vue-router'
import VueAnime from 'vue-animejs'
import FlexboxgridVue from '@vivid-web/flexboxgrid-vue';
import App from './App'
import routes from './routes'

Vue.use(FlexboxgridVue);
Vue.use(VueAnime);
Vue.use(VueRouter);
Vue.config.productionTip = false

const router = new VueRouter({ routes })

new Vue({
    render: h => h(App),
    router,
}).$mount('#app');