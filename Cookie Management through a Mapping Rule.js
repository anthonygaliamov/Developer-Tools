// Mapping Rule Function
var cookie = {
    set(name, value, days){
        if (!days);
            var exdate = new Date();
            exdate.setDate(exdate.getDate() + days);
            setExpiry = "; expires=" + exdate.toGMTString();
        return macros.put("@SETCOOKIE@","" + name + "=" + value + "; path=/; HttpOnly; Secure" + setExpiry + ";");
    },
    remove(name){
        return macros.put("@SETCOOKIE@","" + name + "=; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT;");
    },
    get(name, array){
        var cookie = ""
            for ( i = 0; i < array.length; i++){
                cookieArr =  array[i].trim().split("=");
                    if (cookieArr[0] == name)
                        cookie = cookieArr[1];
            }
        return cookie;
    }
};

// Calling Function in Mapping Rules
cookie.set("SSOID", ssoCookieJWT, null);
// Or
cookie.remove("cookieName");
// Or
var cookiesArray = context.get(Scope.REQUEST, "urn:ibm:security:asf:request:header", "Cookie").split(";");
var ssoIdCookie = cookie.get("SSOID", cookiesArray);

// Template Function
var cookie = "" + macro("@SETCOOKIE@");
if(cookie.length > 0){
    templateContext.response.setHeader("Set-Cookie", cookie);
}
