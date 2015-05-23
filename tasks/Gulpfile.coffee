gulp = require 'gulp'
gls = require 'gulp-live-server'
browserify = require 'browserify'
ngHtml2Js = require 'browserify-ng-html2js'
source = require 'vinyl-source-stream'
gulpMocha = require 'gulp-mocha'
gutil = require 'gulp-util'

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

gulp.task 'mocha', ->
  gulp.src('server/test/**/*.coffee', {read: false})
  .pipe(gulpMocha())
  .on 'error', gutil.log

gulp.task 'watch-mocha', ->
  gulp.watch ['../server/src/**/*.coffee', '../server/test/**/*.coffee'], ['mocha']
