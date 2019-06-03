<%@ page import="canvas.SignedRequest" %>
<%@ page import="java.util.Map" %>
<%
    // Pull the signed request out of the request body and verify/decode it.
    Map<String, String[]> parameters = request.getParameterMap();
    String[] signedRequest = parameters.get("signed_request");
    System.out.println(parameters.toString());
    if (signedRequest == null) {%>
        This App must be invoked via a signed request!<%
        return;
    }
    String yourConsumerSecret=System.getenv("CANVAS_CONSUMER_SECRET");
    //String yourConsumerSecret="1818663124211010887";
    String signedRequestJson = SignedRequest.verifyAndDecodeAsJson(signedRequest[0], yourConsumerSecret);
%>

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
        function callback(msg) {
            if (msg.status !== 200) {
                
                Sfdc.canvas.byId('payload').innerHTML = JSON.stringify(msg, null, 4);
                return;
            }
            
            Sfdc.canvas.byId('payload').innerHTML = JSON.stringify(msg.payload, null, 4);
        }

        function getContext(){
            console.log('Calling context');
            
            var client = Sfdc.canvas.oauth.client();
            console.log('client (oauth) - '+JSON.stringify(client));
            console.log('client (SR) - '+sr.client)
            Sfdc.canvas.client.ctx(callback, sr.client);
        }

        Sfdc.canvas(function() {
            sr = JSON.parse('<%=signedRequestJson%>');
            // Save the token
            
            console.log("Checking parameters "+location.search);
            

            Sfdc.canvas.oauth.token(sr.oauthToken);
            Sfdc.canvas.byId('username').innerHTML = sr.context.user.fullName;
            Sfdc.canvas.byId('payload').innerHTML = JSON.stringify(sr, null, 4);
        });

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