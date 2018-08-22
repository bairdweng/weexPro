/**
 * Created by baird on 2018/8/20.
 */
var stream = weex.requireModule('stream');
export default {
    requestPost(url, params, callBack){
        stream.fetch({
            method: 'POST',
            url: url,
            type: 'json',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(params),
        }, function (ret) {
            if (ret['data']) {
                callBack(ret['data']);
            }
            else {
                callBack(ret);
            }
        }, function (response) {
            callBack(null);
        });
    }
}