<template>
    <div class="wrapper">
        <!--<image :src="logo" class="logo" />-->
        <!--<text class="greeting">The environment is ready!123132123123123</text>-->
        <!--<router-view/>-->
        <text style="color:red">2222223</text>
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
        mounted(){
//            console.log('123123123131');
            navigator.push({url: Navigation.getJumpBaseUrl('login')});
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
