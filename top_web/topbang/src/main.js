import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

Vue.use(ElementUI)

import './icons' // icon
Vue.config.productionTip = false
// import Sticky from 'vue-sticky-directive'
// Vue.use(Sticky)

// 处理页面跳转后不在顶部问题
router.afterEach((to, from, next) => {
  window.scrollTo(0, 0)
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
