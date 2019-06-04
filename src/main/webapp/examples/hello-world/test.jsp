<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

    <title>Hello World Canvas Test</title>

    <!-- Include all the canvas JS dependencies in one file -->
    <script type="text/javascript" src="/sdk/js/canvas-all.js"></script>
    <!-- Third part libraries, substitute with your own -->
    <script type="text/javascript" src="/scripts/json2.js"></script>

    <script>

        var sr = {};

        function showOnPage(obj){
            Sfdc.canvas.byId('payload').innerHTML = JSON.stringify(obj, null, 4);
        }

        function callback(msg) {
            console.info('Callback from getting context');

            var obj = {};
            if (msg.status !== 200){
                obj = msg;
                Sfdc.canvas.byId('username').innerHTML = sr.context.user.fullName;
            }else obj = msg.payload;
            
            showOnPage(obj);
        }

        function getContext(){
            console.info('Calling context');
            
            var client = Sfdc.canvas.oauth.client();
            console.log('client (oauth) - '+JSON.stringify(client));
            console.log('client (SR) - '+sr.client)
            Sfdc.canvas.client.ctx(callback, sr.client);
        }

        function refresh(){
            Sfdc.canvas.client.refreshSignedRequest(function(data) {
                
                console.info('callback from refresh');
                if (data.status === 200) {
                    var signedRequest =  data.payload.response;
                    var part = signedRequest.split('.')[1];
                    sr = JSON.parse(Sfdc.canvas.decode(part));
                    Sfdc.canvas.byId('username').innerHTML = sr.context.user.fullName;
                    showOnPage(sr);
                }else{
                    showOnPage(data);
                }
            });
        }

        Sfdc.canvas(function() {
            //refresh signed request, lost in the redirects
            console.info('Finished loading, calling refresh');
            refresh();
        });

    </script>
</head>
<body>
    <br/>
    <h1>Hello <span id='username'>Tester</span></h1>

    <p><button id="refButton" onclick="refresh(); return false;">Refresh</button></p>
    <p><button id="ctxButton" onclick="getContext(); return false;">Get Context</button></p>
    <p><button id="repost" onclick="Sfdc.canvas.client.repost();">Repost</button></p>
    <p><a href="./index.jsp">Go to another page</a></p>
    <pre id="payload"></pre>
</body>
</html>