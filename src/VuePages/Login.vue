<template>
    <div class="rootview" @viewappear="onViewappear">
        <div style="height: 40px;background-color: #009ff0;"></div>
        <wxc-minibar title="登录"
                     background-color="#009ff0"
                     text-color="#FFFFFF"
                     left-text=""
                     leftButton=""></wxc-minibar>
        <div class="loginview">
            <div style="top: 20px">
                <input type="text" placeholder="用户名" return-key-type="next" class="input" v-model="userName"/>
                <div class="input_line"></div>
                <input type="password" placeholder="密  码" return-key-type="next" class="input" v-model="passWord"/>
                <div class="input_line"></div>
                <div style="align-items: center">
                    <wxc-button text="登录" :btn-style="login_button"
                                @wxcButtonClicked="loginBtnClick"></wxc-button>
                </div>

                <div style="align-items: center;top: 90px">
                    <wxc-button type="white" text="注册" :btn-style="res_button"
                                @wxcButtonClicked="resBtnClick"></wxc-button>
                </div>
            </div>
        </div>
        <wxc-loading :show="isShow" loading-text="登陆中..."></wxc-loading>
    </div>
</template>

<script>
    import {WxcButton, WxcLoading, WxcMinibar} from 'weex-ui';
    import ApiServices from '../Services/ApiServices';
    const modal = weex.requireModule('modal');
    const navigator = weex.requireModule('navigator');
    const globalEvent = weex.requireModule('globalEvent');
    const customEvent = weex.requireModule('event');
    export default {
        components: {WxcButton, WxcLoading, WxcMinibar},
        name: '登录页面',
        data () {
            return {
                name: '登录2222',
                isShow: false,
                userName: 'bairdweng',
                passWord: '111111'
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
                    width: '200px',
                }
            }
        },
        mounted(){
            try {
                if (navigator) {
                    navigator.setNavBarHidden({hidden: "1"});
                }
            }
            catch (r) {
            }
        },
        created(){
            globalEvent.addEventListener("viewappear", function (e) {
                modal.toast({'message': '2222222222222222', 'duration': 1});
            });
        },
        methods: {
            onViewappear (event) {
                navigator.setNavBarHidden({hidden: "1"});
                customEvent.setStateBarHidden('NO');

            },
            minibarLeftButtonClick(){

            },
            minibarRightButtonClick(){

            },
            loginBtnClick(){
                if (this.isShow) {
                    return;
                }
                this.isShow = true;
                setTimeout(() => {
                    ApiServices.login(this.userName, this.passWord, (ret) => {
                        this.isShow = false;
                        if (ret && ret['state'] === '1') {
                            modal.toast({'message': '登陆成功', 'duration': 1});
                            this.goGamePage();
                        }
                        else if (ret && ret['error']) {
                            modal.toast({'message': ret['error'], 'duration': 1});
                        }
                        else {
                        }
                    });
                }, 1500);
            },
            goGamePage(){
                setTimeout(() => {
                    let nextURL = this.getJumpBaseUrl('game');
                    navigator.push({url: nextURL, animated: 'false'})
                }, 2000);
            },
            resBtnClick(){
                let nextURL = this.getJumpBaseUrl('registered');
                navigator.push({url: nextURL, navShow: false})
            },
            getJumpBaseUrl(toUrl) {
                var bundleUrl = weex.config.bundleUrl;
                bundleUrl = new String(bundleUrl);
                var nativeBase;
                var native;
                if (WXEnvironment.platform === 'Android') {
                    nativeBase = 'file://assets/dist/';
                    native = nativeBase + toUrl + ".js";
                } else if (WXEnvironment.platform === 'iOS') {
                    nativeBase = bundleUrl.substring(0, bundleUrl.lastIndexOf('/') + 1);
                    native = nativeBase + toUrl + ".js";
                } else {
                    var host = 'localhost:8081';
                    var matches = /\/\/([^\/]+?)\//.exec(bundleUrl);
                    if (matches && matches.length >= 2) {
                        host = matches[1];
                    }
                    //此处需注意一下,tabbar 用的直接是jsbundle 的路径,但是navigator是直接跳转到新页面上的.
                    if (typeof window === 'object') {
                        nativeBase = 'http://' + host + '/';
                    } else {
                        nativeBase = 'http://' + host + '/';
                    }
                    native = nativeBase + toUrl + ".html";
                }
                return native;
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
        background-color: #000000;
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
