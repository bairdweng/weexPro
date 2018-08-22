import Vue from 'vue'
import weex from 'weex-vue-render'
/**
 * Created by baird on 2018/8/16.
 */
/*global Vue*/

weex.init(Vue)
/* weex initialized here, please do not move this line */
const router = require('./router');
const App = require('@/VuePages/Login.vue');
/* eslint-disable no-new */
new Vue(Vue.util.extend({el: '#root', router}, App));
router.push('/');

