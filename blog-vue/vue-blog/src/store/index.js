import Vue from 'vue'
import Vuex from 'vuex'


Vue.use(Vuex)
const store = new Vuex.Store({
  state: {
    currentPathName: ''
  },
  mutations: {
    setPath (state) {
      state.currentPathName = localStorage.getItem("currentPathName")
    },
    logout() {
      // 清空缓存
      localStorage.removeItem("user")

    }
  }
})

export default store
