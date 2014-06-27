# En Route

A demonstration of a possible future of web apps: single page apps that use the History API, but that also render perfectly on the server-side too.

## Why is this a good thing?

Imagine if you can have all of this:

* A single page application
* That uses the History API to represent app state with URLs
* And those URLs render perfectly on the server side too

This means you can get all your cakes and eat them too:

* SEO
* Cachability
* Proper deep linking - all application states can have a sharable URL

## How?

Simply define your routes once for both the client _and_ server sides. En Route will render your routes on the server in exactly the same way as it will render them on the client side.
