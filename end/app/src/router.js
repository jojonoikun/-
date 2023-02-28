import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'

import show from './components/show.vue'
Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      children: [
        {
          path: '/show/:id',
          name: 'show',
          component: show,
        }]
    }
  ]
})
