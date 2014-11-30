(function(){
  'use strict';
  var time, request, ref$, map, reject, filter, checkIsNotNull, checkBody, thenHandle, slice$ = [].slice;
  time = 0;
  request = AV._request;
  ref$ = require('prelude-ls'), map = ref$.map, reject = ref$.reject, filter = ref$.filter;
  checkIsNotNull = function(obj){
    var args, i$, len$, name;
    args = slice$.call(arguments, 1);
    for (i$ = 0, len$ = args.length; i$ < len$; ++i$) {
      name = args[i$];
      console.log("check", name, obj, obj != null ? obj[name] : void 8);
      if (!(obj[name] && obj[name] !== 'null' && obj[name] !== 'undefinded')) {
        return name;
      }
    }
    return null;
  };
  checkBody = function(x){
    var arg;
    arg = slice$.call(arguments, 1);
    arguments[0] = arguments[0].body;
    return checkIsNotNull.apply(this, arguments);
  };
  thenHandle = function(res){
    return function(){
      return res.json({
        times: time++,
        results: arguments[0]
      });
    };
  };
  module.exports = function(router){
    router.get('/hello', function(req, res){
      return AV.Cloud.httpRequest(
      {
        url: 'http://www.baidu.com/',
        timeout: 15000,
        headers: {
          'Content-Type': 'application/json'
        },
        success: function(httpResponse){
          console.log("a123", httpResponse);
          return res.render('hello', {
            message: httpResponse.text
          });
        },
        error: function(httpResponse){
          console.log("a123 err", httpResponse);
          return res.render('hello', {
            message: httpResponse.status
          });
        }
      });
    });
    router.get('/xx', function(req, res){
      return res.json({
        result: time++,
        status: map((function(it){
          return it * 2;
        }), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      });
    });
    router.get('/userInit', function(req, res){
      var data, r;
      data = req.query.data;
      data = JSON.parse(data);
      console.log("userInit", JSON.stringify(data));
      r = checkIsNotNull(data, 'currentUser');
      if (r) {
        return res.json({
          times: time,
          results: r
        });
      }
      return request('classes', 'userInfo', null, "POST", data).then(thenHandle(res));
    });
    router.get('/userBase', function(req, res){
      var data, r;
      data = req.query.data;
      data = JSON.parse(data);
      r = checkIsNotNull(data, 'currentUser');
      if (r) {
        return res.json({
          times: time,
          results: r
        });
      }
      return request('classes', 'userBase', null, 'POST', data).then(thenHandle(res));
    });
    router.get('/usingTime', function(req, res){
      var data, r;
      data = req.query.data;
      data = JSON.parse(data);
      r = checkIsNotNull(data, 'currentUser');
      if (r) {
        return res.json({
          times: time,
          results: r
        });
      }
      return request('classes', 'usingTime', null, 'POST', data).then(thenHandle(res));
    });
    router.get('/paintOp', function(req, res){
      var data, result;
      data = req.query.data;
      data = JSON.parse(data);
      result = reject(partialize$.apply(this, [checkBody, [void 8, 'currentUser', 'paint'], [0]]))(
      data);
      console.log("result", result);
      return request('batch', null, null, 'POST', {
        requests: result
      }).then(thenHandle(res));
    });
    router.get('/paintCreate', function(req, res){
      var data, r;
      data = req.query.data;
      data = JSON.parse(data);
      r = checkIsNotNull(data, 'currentUser', 'paint');
      if (r) {
        return res.json({
          times: time,
          results: r
        });
      }
      return request('classes', 'paintNew', null, 'POST', data).then(thenHandle(res));
    });
    router.get('/event', function(req, res){
      var r;
      r = checkIsNotNull(data, 'currentUser');
      if (r) {
        return res.json({
          times: time,
          results: r
        });
      }
      return request('classes', 'testObj', null, "POST", req.query).then(function(){
        console.log("/event?", arguments);
        return res.json(arguments[0]);
      });
    });
    return router.get('/batch', function(req, res){
      var b, result, res$, i$, x$, ref$, len$, lresult$, k, v;
      b = {
        'method': "POST",
        'path': "/1.1/classes/testObj",
        'body': req.query
      };
      res$ = [];
      for (i$ = 0, len$ = (ref$ = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]).length; i$ < len$; ++i$) {
        x$ = ref$[i$];
        lresult$ = [];
        for (k in b) {
          v = b[k];
          lresult$[k] = v;
        }
        res$.push(lresult$);
      }
      result = res$;
      return request('batch', null, null, "POST", {
        requests: arr
      }).then(function(){
        return res.json(arguments[0]);
      });
    });
  };
  function partialize$(f, args, where){
    var context = this;
    return function(){
      var params = slice$.call(arguments), i,
          len = params.length, wlen = where.length,
          ta = args ? args.concat() : [], tw = where ? where.concat() : [];
      for(i = 0; i < len; ++i) { ta[tw[0]] = params[i]; tw.shift(); }
      return len < wlen && len ?
        partialize$.apply(context, [f, ta, tw]) : f.apply(context, ta);
    };
  }
}).call(this);
