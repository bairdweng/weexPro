<template>
    <div class="wrapper">
        <!--<div dataRole = "navbar" :style="{  backgroundColor: 'black' }"></div>-->
        <!--<image :src="logo" class="logo" />-->
        <!--<text class="greeting">The environment is ready!123132123123123</text>-->
        <!--<router-view/>-->
        <text style="color:red" @click="clickOntheText">123123</text>
    </div>
</template>
<script>
    import Navigation from './helper/Navigation'
    const navigator = weex.requireModule('navigator');
    export default {
        name: 'App',
        data () {
            return {}
        },
        methods: {
            clickOntheText(){
                navigator.push({url: Navigation.getJumpBaseUrl('login')});
//                console.log('1231313123');
//                alert('123');
            }
        },
        mounted(){
//            console.log('123123123131');
//            navigator.push({url: Navigation.getJumpBaseUrl('login')});
        }
    }
</script>

<style scoped>
    .wrapper {
        justify-content: center;
        align-items: center;
    }

    .logo {
        width: 424px;
        height: 200px;
    }

    .greeting {
        text-align: center;
        margin-top: 70px;
        font-size: 50px;
        color: #41B883;
    }

    .message {
        margin: 30px;
        font-size: 32px;
        color: #727272;
    }
</style>
