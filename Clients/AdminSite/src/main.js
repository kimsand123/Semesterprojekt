import Vue from 'vue'
import VueAnime from 'vue-animejs'
import FlexboxgridVue from '@vivid-web/flexboxgrid-vue';
import App from './App'
import router from './router'

Vue.use(FlexboxgridVue);
Vue.use(VueAnime);
Vue.config.productionTip = false

new Vue({
    el: '#app',
    router,
    components: { App },
    template: '<App/>'
})