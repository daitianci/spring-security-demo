# 工程简介



# 延伸阅读
授权码请求地址
http://localhost:8001/oauth/authorize?client_id=client1&redirect_uri=http://localhost:8888/callback&response_type=code&scope=all

客户端请求地址
curl -X POST "http://localhost:8001/oauth/token"  --user client1:123456  -d "grant_type=client_credentials&scope=all"

#资源服务器请求
curl -X GET http://localhost:8001/api/hello -H "authorization: Bearer 305f9638-95b0-404f-83d3-b8887127b00e"
