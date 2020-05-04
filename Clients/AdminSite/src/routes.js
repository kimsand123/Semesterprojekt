import LandingPage from '@/components/pages/LandingPage'
import Players from '@/components/pages/show/Players'
import PlayersAdd from '@/components/pages/add/Players'
import Games from '@/components/pages/show/Games'
import Questions from '@/components/pages/show/Questions'
import QuestionsAdd from '@/components/pages/add/Questions'
import Invitations from '@/components/pages/show/Invitations'
import InvitationsAdd from '@/components/pages/add/Invitations'

const routes = [
    { path: '/', component: LandingPage },
    { path: '/players', component: Players },
    { path: '/players/add', component: PlayersAdd },
    { path: '/games', component: Games },
    { path: '/questions', component: Questions },
    { path: '/questions/add', component: QuestionsAdd },
    { path: '/invitations', component: Invitations },
    { path: '/invitations/add', component: InvitationsAdd },
]

export default routes