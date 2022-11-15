import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    component: () => import('../views/Front.vue'),
    redirect: "/home",
    children: [
      { path: 'home', name: '首页', component: () => import('../views/Home.vue')},
      { path: 'article', name: '文章管理', component: () => import('../views/Article.vue')},
      { path: 'articleDetail', name: '文章详情', component: () => import('../views/ArticleDetail.vue')},
      { path: 'link', name: '友链管理', component: () => import('../views/Link.vue')},
      { path: 'aboutMe', name: '关于我', component: () => import('../views/AboutMe.vue')},
      {path: '/person', name: 'Person', component: () => import('../views/Person.vue')},
    ]
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('../views/Register.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue')
  },


]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})
// 路由守卫



export default router
