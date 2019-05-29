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
                alert("Error: " + msg.status);
                return;
            }
            alert("Payload: ", msg.payload);
        }

        var client = Sfdc.canvas.oauth.client();
        var ctxButton = Sfdc.canvas.byId("ctxButton");
        ctxButton.onclick = function () {
            Sfdc.canvas.client.ctx(callback, client);
            return false;
        };

    </script>
</head>
<body>
    <br/>
    <h1>Hello <span id='username'>Tester</span></h1>

    <p><button id="ctxButton">Get Context</button></p>
    <p><a href="./index.jsp">Go to another page</a></p>
</body>
</html>