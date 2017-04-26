import Vue from 'vue'
import Router from 'vue-router'
import NavBar from '@/components/NavBar'
import AddRoom from '@/components/AddRoom'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'NavBar',
      component: NavBar,
      children: [
        { path: '/add-room', component: AddRoom }
      ]
    }
  ]
})
