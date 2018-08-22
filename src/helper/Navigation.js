/**
 * Created by baird on 2018/8/20.
 */

export default {
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