import Vue from 'vue'
import Router from 'vue-router'
import LandingPage from '@/components/pages/LandingPage'
import HomePage from '@/components/pages/HomePage'

Vue.use(Router)

export default new Router({
    routes: [{
            path: '/',
            name: 'LandingPage',
            component: LandingPage
        },
        {
            path: '/home-page',
            name: 'HomePage',
            component: HomePage
        }
    ]
})