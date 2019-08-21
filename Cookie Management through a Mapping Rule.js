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
    }
};

// Calling Function in Mapping Rules
cookie.set("SSOID", ssoCookieJWT, null);
// Or
cookie.remove("cookieName");

// Template Function
var cookie = "" + macro("@SETCOOKIE@");
if(cookie.length > 0){
    templateContext.response.setHeader("Set-Cookie", cookie);
}
