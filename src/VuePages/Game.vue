<template>
    <div class="game_rootview" @viewappear="onViewappear">
        <web ref="webview" class="gamewebview" :src="url"></web>
    </div>
</template>

<script>

    import {WxcButton, WxcLoading} from 'weex-ui'
    const modal = weex.requireModule('modal');
    const customEvent = weex.requireModule('event');
    const navigator = weex.requireModule('navigator');
    export default {
        components: {WxcButton},
        name: '游戏页面',
        data () {
            return {
                name: '登录2222',
                url: 'https://play.famobi.com/burnin-rubber'

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
        created(){
            customEvent.setStateBarHidden('YES');
//            modal.toast({'message': '2222222222222222', 'duration': 1});
        },
        methods: {
            onViewappear(){
                modal.toast({'message': '=======onViewappear', 'duration': 1});
//                customEvent.setStateBarHidden('YES');
            },
            loginBtnClick(e){

//                modal.toast({'message': '点击了登录', 'duration': 1});
//                customEvent.
            },
            resBtnClick(){
                let nextURL = this.getJumpBaseUrl('registered');
                navigator.push({url: nextURL})
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
    .game_rootview {
        position: absolute;
        top: 0px;
        left: 0px;
        bottom: 40px;
        right: 0px;
    }

    .gamewebview {
        position: absolute;
        top: -40px;
        left: 0px;
        right: 0px;
        bottom: 0px;
        background-color: white;
    }
</style>
