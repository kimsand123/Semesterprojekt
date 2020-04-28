import LandingPage from '@/components/pages/LandingPage'
import Players from '@/components/pages/show/Players'
import PlayersAdd from '@/components/pages/add/Players'
import PlayersEdit from '@/components/pages/edit/Players'
import PlayersDelete from '@/components/pages/delete/Players'
import Games from '@/components/pages/show/Games'
import Questions from '@/components/pages/show/Questions'
import Invitations from '@/components/pages/show/Invitations'

const routes = [
    { path: '/', component: LandingPage },
    { path: '/players', component: Players },
    { path: '/players/add', component: PlayersAdd },
    { path: '/players/edit', component: PlayersEdit },
    { path: '/players/delete', component: PlayersDelete },
    { path: '/games', component: Games },
    { path: '/questions', component: Questions },
    { path: '/invitations', component: Invitations },
]

export default routes