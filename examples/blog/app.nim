import ../../src/prologue
import urls

let
  env = loadPrologueEnv(".env")
  settings* = newSettings(appName = env.getOrDefault("appName", "Prologue"),
                debug = env.getOrDefault("debug", true),
                port = Port(env.getOrDefault("port", 8080)),
                staticDirs = env.get("staticDir"),
                secretKey = SecretKey(env.getOrDefault("secretKey", "")),
                dbPath = "blog.db"
    )

var
  app = newApp(settings = settings, middlewares = @[debugRequestMiddleware()])

app.addRoute(urls.urlPatterns, "")
app.run()