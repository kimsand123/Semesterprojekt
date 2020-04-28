import LandingPage from '@/components/pages/LandingPage'
import HomePage from '@/components/pages/HomePage'
import Players from '@/components/pages/Players'
import Games from '@/components/pages/Games'
import Questions from '@/components/pages/Questions'
import Invitations from '@/components/pages/Invitations'

const routes = [
    { path: '/', component: LandingPage },
    { path: '/homepage', component: HomePage },
    { path: '/players', component: Players },
    { path: '/games', component: Games },
    { path: '/questions', component: Questions },
    { path: '/invitations', component: Invitations },
]

export default routes