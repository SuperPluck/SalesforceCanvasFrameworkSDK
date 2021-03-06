<html>
<head>
    <script type="text/javascript" src="/sdk/js/canvas-all.js"></script>
</head>
<body>
    <script>
        function callback(msg) {
            if (msg.status !== 200) {
                
                Sfdc.canvas.byId('payload').innerHTML = JSON.stringify(msg, null, 4);
                return;
            }
            
            Sfdc.canvas.byId('payload').innerHTML = JSON.stringify(msg.payload, null, 4);
        }
        
        function logIn(){
            console.log('Loggin in');
            var uri = Sfdc.canvas.oauth.loginUrl();
            Sfdc.canvas.oauth.login(
                {uri : uri,
                    params: {
                        response_type : "token",
                        client_id : "3MVG96_7YM2sI9wQJ_CmTmye8OfLBd9yKjX58UZ1s4iNUiRDXMuOcXmvGY9qWX.ZhYANvaWkWumOiEfdJl.J2",
                        redirect_uri : encodeURIComponent(
                            "https://sfdccanvassdk2.herokuapp.com/sdk/callback.html")
                    }});
        }

        function loginHandler(e) {
            if (! Sfdc.canvas.oauth.loggedin()) {
                logIn();
            }
            else {
                Sfdc.canvas.oauth.logout();
                login.innerHTML = "Login";
                Sfdc.canvas.byId("oauth").innerHTML = "";
            }
            return false;
        }

        function getContext(){
            console.log('Calling context');
            
            var client = Sfdc.canvas.oauth.client();
            console.log('client '+JSON.stringify(client));
            Sfdc.canvas.client.ctx(callback, client);
        }

        // Bootstrap the page once the DOM is ready.
        Sfdc.canvas(function() {
            // On Ready...
            var login    = Sfdc.canvas.byId("login"),
                loggedIn = Sfdc.canvas.oauth.loggedin(),
                token = Sfdc.canvas.oauth.token();

            login.innerHTML = (loggedIn) ? "Logout" : "Login";
            if (loggedIn) {
                 // Only displaying part of the OAuth token for better formatting.
                Sfdc.canvas.byId("oauth").innerHTML = Sfdc.canvas.oauth.token();
            }else{
                logIn();
            }
            login.onclick=loginHandler;
        });
    </script>

    <h1 id="header">Canvas OAuth App</h1>
    <div>
        access_token = <span id="oauth"></span>
    </div>
    <div>
        <a id="login" href="#">Login</a><br/>
    </div>

    
    <p><button id="ctxButton" onclick="getContext(); return false;">Get Context</button></p>
    <pre id="payload"></pre>
</body>
</html>