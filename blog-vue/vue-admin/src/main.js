import Vue from 'vue'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import './assets/gloable.css'
import request from "@/utils/request";
import store from './store'
import mavonEditor from 'mavon-editor'     //引入mavon-editor组件
import 'mavon-editor/dist/css/index.css'
//引入组件的样式
Vue.use(mavonEditor)
Vue.config.productionTip = false
Vue.use(ElementUI, { size: "mini" });
Vue.prototype.request=request
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
