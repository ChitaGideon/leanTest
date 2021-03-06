'use strict'
time = 0;
request = AV._request;
{map,reject,filter} = require('prelude-ls')
checkIsNotNull = (obj,...args)->
  for name in args
    console.log "check",name,obj,obj?[name]
    if !(obj[name] && obj[name]!='null' && obj[name] != 'undefinded')
      return name
  return null

checkBody = (x,...arg)->
  arguments[0]=arguments[0].body
  checkIsNotNull.apply(this,arguments)

thenHandle =  (res)->
  -> res.json times:time++ ,results: arguments[0]
#ajax = AV._ajax
#AV._request = ->
  #console.log "ajax",arguments
  ##ajax.apply null,arguments
#GameScore = AV.Object.extend("userBase");
#query = new AV.Query(GameScore);
#query.equalTo("level1", "superPage");
#query.find({
  #success: (results)->
    ##alert("Successfully retrieved " + results.length + " scores.");
    #for (i = 0; i < results.length; i++) 
      #object = results[i];
    #console.log "success",results
  #error: (error)->
    #console.log("Error: " + error.code + " " + error.message);
#});
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
    result = data
    |> reject checkBody _,\currentUser,\paint
    #|> each (.metho)
    #r = checkIsNotNull data, \currentUser
    #return res.json times:time,results:r if r
    console.log "result",result
    request 'batch', null,null,'POST',requests:result .then thenHandle res
    #res.json status:true,results:requests:result

  router.get '/paintCreate',(req,res)->
    data = req.query.data
    data = JSON.parse data
    r = checkIsNotNull data, \currentUser,\paint
    return res.json times:time,results:r if r
    request 'classes', 'paintNew',null,'POST',data .then thenHandle res

  router.get '/queryAll/:classes/:tableName',(req,res)->
    {classes,tableName}=req.params
    {oid,method,dataObject} = req.query
    classes||='classes'
    method||='GET'
    dataObject||='{}';
    #console.log('queryAll',classes,tableName,oid,method,dataObject)
    request classes,tableName,oid,method,JSON.parse dataObject .then thenHandle res
    #AV._ajax(request classes,tabelName,oid,method,JSON.stringify dataObject .then thenHandle res

  router.get '/times',(req,res)->
    res.json status:true,times:time

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


