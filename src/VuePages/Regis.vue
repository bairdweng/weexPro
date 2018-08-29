<template>
    <!--<div style="width: 100%;height: 100%;position: absolute">-->
    <!--<div  style="background: red;width: 100%;height: 100%">-->
    <div class="rootview" @viewappear="onViewappear">
        <div style="height: 40px;background-color: #009ff0;"></div>
        <wxc-minibar title="注册"
                     background-color="#009ff0"
                     text-color="#FFFFFF"
                     left-text=""
                     @wxcMinibarLeftButtonClicked="minibarLeftButtonClick"
        ></wxc-minibar>
        <div class="loginview">
            <div style="top: 20px">
                <input type="text" placeholder="用户名" return-key-type="next" class="input"/>
                <div class="input_line"></div>
                <input type="password" placeholder="密  码" return-key-type="next" class="input"/>
                <div class="input_line"></div>
                <div style="align-items: center">
                    <wxc-button text="注册" :btn-style="login_button"
                                @wxcButtonClicked="loginBtnClick"></wxc-button>
                </div>
                <div style="align-items: center;top: 90px">
                    <wxc-button type="white" text="注册" :btn-style="res_button"
                                @wxcButtonClicked="resBtnClick"></wxc-button>
                </div>
            </div>

        </div>
    </div>
</template>

<script>

    const modal = weex.requireModule('modal');
    const navigator = weex.requireModule('navigator');
    import {WxcButton, WxcLoading, WxcMinibar} from 'weex-ui';

    export default {
        components: {WxcButton, WxcLoading, WxcMinibar},
        name: '注册页面',
        data () {
            return {
                name: '登录2222'
            }
        },
        computed: {
            login_button(){
                return {
                    top: '25px',
                    'text-align': 'center',
                    width: '600px',
                }
            },
            res_button(){
                return {
                    width: '120px',
                }
            }
        },
        mounted(){
//            cosole.log('')
        },
        methods: {
            onViewappear(){
                navigator.setNavBarHidden({hidden: "1"});

            },
            loginBtnClick(e){
                modal.toast({'message': '点击了登录', 'duration': 1});
            },
            resBtnClick(e){
                modal.toast({'message': '点击了注册按钮', 'duration': 1});
            }
        }
    }
</script>

<style scoped>
    .rootview {
        position: absolute;
        top: 0;
        left: 0;
        bottom: 0;
        right: 0;
        /*height: 1334px;*/
        background-color: black;
    }

    .input_line {
        /*width: 100%;*/
        height: 1px;
        /*position: absolute;*/
        background-color: red;
    }

    .input {
        /*background-color: red;*/
        margin-left: 15px;
        margin-right: 15px;
        height: 88px;
        /*border-bottom-width: 2px;*/
        /*border-color: #41B883;*/
    }

    .loginview {
        position: absolute;
        top: 200px;
        left: 40px;
        right: 40px;
        height: 500px;
        background-color: white;
        border-radius: 20px;
    }
</style>
