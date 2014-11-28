'use strict'
time = 0;
request = AV._request;
{map} = require('prelude-ls')
checkIsNotNull = (obj,...args)->
  for name in args
    console.log "check",name,obj,obj?[name]
    if !(obj[name] && obj[name]!='null' && obj[name] != 'undefinded')
      return name
  return null


thenHandle =  (res)->
  -> res.json times:time++ ,results: arguments[0]

module.exports = (router) -> 
  #router.route(/.*/).all (req, res) -> 
    #res.send AV._request
  router.get '/hello', (req, res)->
    * url: 'http://www.baidu.com/'
      timeout: 15000
      headers:
        'Content-Type': 'application/json'
      success: (httpResponse)->
        console.log "a123",httpResponse
        res.render('hello', { message: httpResponse.text})
      error: (httpResponse)->
        console.log "a123 err",httpResponse
        res.render('hello', { message: httpResponse.status})
    |> AV.Cloud.httpRequest

  router.get '/xx',(req,res)->
    res.json result:time++ status: map (* 2),[1 to 10]

  router.get '/userInit',(req,res)->
    data = req.query.data
    data = JSON.parse data
    console.log "userInit",JSON.stringify data
    r = checkIsNotNull(data,\currentUser);
    return res.json times:time,results:r if r
    request('classes','userInfo',null,"POST",data).then thenHandle res

  router.get '/userBase',(req,res)->
    data = req.query.data
    data = JSON.parse data
    r = checkIsNotNull(data,\currentUser);
    return res.json times:time,results:r if r
    request 'classes','userBase',null,'POST',data .then thenHandle res

  router.get '/usingTime',(req,res)->
    data = req.query.data
    data = JSON.parse data
    r = checkIsNotNull data, \currentUser
    return res.json times:time,results:r if r
    request 'classes', 'usingTime',null,'POST',data .then thenHandle res

  router.get '/paintOp',(req,res)->
    data = req.query.data
    data = JSON.parse data
    r = checkIsNotNull data, \currentUser,\pid
    return res.json times:time,results:r if r
    request 'classes', 'usingTime',null,'POST',data .then thenHandle res

  router.get '/event',(req,res)->
    r = checkIsNotNull data, \currentUser
    return res.json times:time,results:r if r
    request('classes','testObj',null,"POST",req.query).then ->
      console.log "/event?",arguments
      res.json arguments[0]

  router.get '/batch',(req,res)->
    b =
      \method : "POST"
      \path : "/1.1/classes/testObj"
      \body : req.query
    result = [{[k,v] for k,v of b} for [1 to 10]]
    request('batch',null,null,"POST",requests:arr).then ->
      res.json arguments[0]


