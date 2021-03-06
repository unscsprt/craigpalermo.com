# module dependencies
express = require('express')
jade = require('jade')
stylus = require('stylus')
nib = require('nib')
coffee = require('express-coffee')

# function to compile stylus
compile = (str, path) ->
  return stylus(str).set('filename', path).use(nib())

# set up express app
app = module.exports = express()

# set up directory paths
app.set('views', __dirname + '/views')
app.set('view engine', 'jade')

# stylus middleware
app.use(stylus.middleware(
  src: __dirname + '/public'
  compile: compile
))

# coffeescript middleware
app.use(coffee(
  path: __dirname + '/public'
  uglify: false
))

app.use(express.static(__dirname + '/public'))

# Begin routes -------------------------------------

# landing page
home = (req, res) ->
  res.render('home', {title: "Craig Palermo - Web Developer"})

# services page
services = (req, res) ->
  res.render('services', {title: "Craig Palermo - Services"})

# Routes
app.get('/', home)
app.get('/services', services)

# End routes -------------------------------------

# listen server on port 3001
app.listen(process.env.PORT || 3002)
