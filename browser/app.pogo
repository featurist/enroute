React = require 'react'
r = React.DOM
surlaroute = require './surlaroute'

page1 = React.createClass {
  displayName = 'page1'

  render () =
    r.div {} (self.props.data, r.a {href = '/blah.html', onClick = surlaroute.navigate} 'blah')
}

blahPage = React.createClass {
  displayName = 'blahPage'

  render () =
    r.div {} 'blah ' (r.a {href = '/', onClick = surlaroute.navigate} 'home')
}

surlaroute.page (page1)
surlaroute.page (blahPage)

surlaroute.get '/'
  page1 {data = 'initial'}

surlaroute.get '/blah.html' @(request)
  blahPage {}
