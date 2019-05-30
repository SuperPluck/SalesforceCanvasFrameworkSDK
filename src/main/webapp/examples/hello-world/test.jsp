<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

    <title>Hello World Canvas Test</title>

    <!-- Include all the canvas JS dependencies in one file -->
    <script type="text/javascript" src="/sdk/js/canvas-all.js"></script>
    <!-- Third part libraries, substitute with your own -->
    <script type="text/javascript" src="/scripts/json2.js"></script>

    <script>
        function callback(msg) {
            if (msg.status !== 200) {
                
                Sfdc.canvas.byId('payload').innerHTML = JSON.stringify(msg, null, 4);
                return;
            }
            
            Sfdc.canvas.byId('payload').innerHTML = JSON.stringify(msg.payload, null, 4);
        }

        function getContext(){
            Sfdc.canvas.client.ctx(callback, Sfdc.canvas.oauth.client());
        }
    </script>
</head>
<body>
    <br/>
    <h1>Hello <span id='username'>Tester</span></h1>

    <p><button id="ctxButton" onclick="getContext(); return false;">Get Context</button></p>
    <p><button id="repost" onclick="Sfdc.canvas.client.repost();">Repost</button></p>
    <p><a href="./index.jsp">Go to another page</a></p>
    <pre id="payload"></pre>
</body>
</html>