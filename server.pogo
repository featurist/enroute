express = require 'express'
React = require 'react'
surlaroute = require './browser/surlaroute'
require './browser/app'
browserify = require 'browserify-middleware'

app = express()

app.use @(req, res, next)
  path = req.path
  component = surlaroute.route (req.method, req.path)

  if (component)
    componentName = component.constructor.displayName
    page = "<html>
              <head>
              </head>
              <body>
                #(React.renderComponentToString(component))
                <script src=app.pogo></script>
                <script>
                  surlaroute.init(#(JSON.stringify(componentName)), #(JSON.stringify(component.props)))
                </script>
              </body>
            </html>"

    res.send(page)
  else
    next()

app.use (browserify ('./browser', {transform = ['pogoify'], extensions = ['.pogo'], grep = r/(\.pogo|\.js|\.less)$/}))

app.listen 5001
