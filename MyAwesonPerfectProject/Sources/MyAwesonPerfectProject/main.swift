import PerfectHTTP
import PerfectHTTPServer

var routes = Routes()
routes.add(method: .get, uri: "/") {
    request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello,world!</body></html>").completed()
}

do {
    try HTTPServer.launch(
        .server(name:"www.example.ca", port:8181, routes:routes))
} catch {
    fatalError("\(error)")
}
