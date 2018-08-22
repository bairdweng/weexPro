/**
 * Created by baird on 2018/8/20.
 */
import Request from './Request'
export default {
    login(userName, password, callBack){
        let parames = {
            'userName': userName,
            'passWord': password
        };
        let POST_URL = 'https://xggserve.com/xgg/gamelogin';
        Request.requestPost(POST_URL, parames, callBack);
    }
}