React = require 'react'
r = React.DOM

click (event) =
  event.stopPropagation()
  event.preventDefault()

exports.navigate(event) =
  try
    href = event.target.getAttribute 'href'
    history.pushState (nil, '', href)
    pageComponent.route ('get', href, nil)
  catch (e)
    console.log(e)
  finally
    event.stopPropagation()
    event.preventDefault()

exports.route (method, path, body) =
  methodRoutes = if (method == 'post')
    routes.post
  else
    routes.get

  handler = [route <- methodRoutes, route.path.test (path), route.handler].0

  if (handler)
    handler {
      path = path
      body
    }

routes = {
  get = []
  post = []
}

regexify (path) =
  new (RegExp ("^#(path)$"))

exports.get (path, handler) =
  routes.get.push {path = regexify (path), handler = handler}

exports.post (path, handler) =
  routes.post.push {path = regexify (path), handler = handler}

page = React.createClass {
  getInitialState() =
    { body = self.props.component (self.props.props) }

  route (method, url, body) =
    responseBody = exports.route (method, url, body) @or r.div {} "no route for: #(method) #(path) #(JSON.stringify(body)) " (r.a {href = '/blah.html', onClick = exports.navigate} 'haha nav')

    self.setState {body = responseBody}

  componentDidMount() =
    self.popstate = popstate (event) =
      method =
        if (event.state)
          'post'
        else
          'get'

      path = location.pathname + location.search + location.hash
      self.route (method, path, event.state)

    window.addEventListener 'popstate' (self.popstate)

  componentWillUnmount() =
    window.removeEventListener 'popstate' (self.popstate)

  render() =
    self.state.body
}

pageComponent = nil
pages = []
initial = nil

exports.page(component) =
  pages.(component.componentConstructor.displayName) = component

exports.init(componentName, props) =
  initial := { component = pages.(componentName), props = props }

if (typeof (window) != 'undefined')
  window.surlaroute = exports
  window.addEventListener 'load'
    pageComponent := React.renderComponent(page(initial), document.body)
