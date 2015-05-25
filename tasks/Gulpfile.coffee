gulp = require 'gulp'
gls = require 'gulp-live-server'
browserify = require 'browserify'
ngHtml2Js = require 'browserify-ng-html2js'
source = require 'vinyl-source-stream'
bcrypt = require 'bcrypt' # this is here so the tests watch will work: https://github.com/sindresorhus/gulp-mocha/issues/86
mocha = require 'gulp-mocha'
gutil = require 'gulp-util'
watch = require 'gulp-watch'
plumber = require 'gulp-plumber'
batch = require 'gulp-batch'

gulp.task 'default', ['serve'], ->

gulp.task 'serve', ->
  # Start the server at the beginning of the task 
  server = gls.new('app.js')
  server.start()
  # Restart the server when file changes 
  gulp.watch [
    'app.js'
    'server/src/**/*.coffee'
  ], [ server.start ]
  return

gulp.task 'browserify', ->
  b = browserify
    entries: ['client/app.coffee'],
    extensions: ['.js', '.coffee']
  .transform 'coffeeify'
  .transform ngHtml2Js(
    module: 'templates',
    baseDir: 'client')
  .bundle()
  .pipe source 'main.js'
  .pipe gulp.dest 'client/dist'

onError = (err) ->
  console.log err.toString()
  @emit 'end'

gulp.task 'mocha', ->
  gulp.src(['server/test/**/*.coffee'], read: false)
  .pipe mocha()
  .on 'error', onError

gulp.task 'test', ['mocha'], ->  
  gulp.watch(
    [
      'server/src/**/*.coffee'
      'server/test/**/*.coffee'
    ]
    ['mocha']
  )

  
