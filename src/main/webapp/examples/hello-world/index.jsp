<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

    <title>Hello World Canvas Example</title>

    <!-- Include all the canvas JS dependencies in one file -->
    <script type="text/javascript" src="/sdk/js/canvas-all.js"></script>
    <!-- Third part libraries, substitute with your own -->
    <script type="text/javascript" src="/scripts/json2.js"></script>

    <script>

        /*Sfdc.canvas(function() {
            var sr = JSON.parse('<%=signedRequestJson%>');
            console.log(sr);
            // Save the token
            
            console.log("Checking parameters "+location.search);


            Sfdc.canvas.oauth.token(sr.oauthToken);
            Sfdc.canvas.byId('username').innerHTML = sr.context.user.fullName;
            Sfdc.canvas.byId('payload').innerHTML = JSON.stringify(sr, null, 4);
        });*/

        var sr = {};

        function showOnPage(obj){
            Sfdc.canvas.byId('payload').innerHTML = JSON.stringify(obj, null, 4);
        }

        function refresh(){
            Sfdc.canvas.client.refreshSignedRequest(function(data) {
                
                console.info('callback from refresh');
                if (data.status === 200) {
                    console.log('refresh successfull');
                    var signedRequest =  data.payload.response;
                    var part = signedRequest.split('.')[1];
                    sr = JSON.parse(Sfdc.canvas.decode(part));
                    Sfdc.canvas.byId('username').innerHTML = sr.context.user.fullName;
                    showOnPage(sr);
                }else{
                    console.error('callback failed');
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

    <h1>Hello <span id='username'></span></h1>
    <p><a href="./test.jsp">Go to another page</a></p>
    <pre id="payload"></pre>
</body>
</html>
