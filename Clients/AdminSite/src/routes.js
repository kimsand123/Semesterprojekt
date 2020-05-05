import LandingPage from '@/components/pages/LandingPage'
import Players from '@/components/pages/Show/Players'
import PlayersAdd from '@/components/pages/Add/Players'
import Games from '@/components/pages/Show/Games'
import GamesAdd from '@/components/pages/Add/Games'
import Questions from '@/components/pages/Show/Questions'
import QuestionsAdd from '@/components/pages/Add/Questions'
import Invitations from '@/components/pages/Show/Invitations'
import InvitationsAdd from '@/components/pages/Add/Invitations'

const routes = [
    { path: '/', component: LandingPage },
    { path: '/players', component: Players },
    { path: '/players/add', component: PlayersAdd },
    { path: '/games', component: Games },
    { path: '/games/add', component: GamesAdd },
    { path: '/questions', component: Questions },
    { path: '/questions/add', component: QuestionsAdd },
    { path: '/invitations', component: Invitations },
    { path: '/invitations/add', component: InvitationsAdd },
]

export default routes