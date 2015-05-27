gulp = require 'gulp'
gls = require 'gulp-live-server'
browserify = require 'browserify'
ngHtml2Js = require 'browserify-ng-html2js'
source = require 'vinyl-source-stream'
bcrypt = require 'bcrypt' # this is here so the tests watch will work: https://github.com/sindresorhus/gulp-mocha/issues/86
mocha = require 'gulp-mocha'
gutil = require 'gulp-util'
watchify = require 'watchify'
_ = require 'lodash'
buffer = require 'vinyl-buffer'
sourcemaps = require 'gulp-sourcemaps'
sass = require 'gulp-sass'
concatCss = require 'gulp-concat-css'

gulp.task 'default', [
  'browserify'
  'sass:watch'
  'serve'
]

# server stuff
gulp.task 'serve', ->
  # Start the server at the beginning of the task 
  server = gls.new('index.js')
  server.start()
  # Restart the server when file changes 

  gulp.watch [
    'client/dist/main.js'
    'client/dist/main.css'
    'client/index.html'
  ], server.notify
  gulp.watch [
    'index.js'
    'server/src/**/*.coffee'
  ], server.start

# server testing stuff
onError = (err) ->
  console.log err.toString()
  @emit 'end'

gulp.task 'mocha', ->
  gulp.src(['server/test/**/*.coffee'], read: false)
  .pipe mocha()
  .on 'error', onError

gulp.task 'test:server', ['mocha'], ->  
  gulp.watch(
    [
      'server/src/**/*.coffee'
      'server/test/**/*.coffee'
    ]
    ['mocha']
  )

# client stuff
opts = _.assign({}, watchify.args, {
  entries: ['client/app/app.coffee']
  extensions: ['.js', '.coffee', '.html']
  debug: true
})

# TODO: decuple watchify so we can just call browserify without watch
b = watchify(browserify(opts), {poll: true})
.transform 'coffeeify'
.transform ngHtml2Js(
  module: 'templates',
  baseDir: 'client/app')

bundle = ->
  b.bundle()
  .on('error', gutil.log.bind(gutil, 'Browserify Error'))
  .pipe(source('main.js'))
  .pipe(buffer())
  .pipe(sourcemaps.init(loadMaps: true))
  .pipe(sourcemaps.write('./'))
  .pipe gulp.dest('./client/dist')

gulp.task 'browserify', bundle
b.on 'update', bundle
b.on 'log', gutil.log

gulp.task 'sass', ->
  gulp.src 'client/sass/**/*.sass'
  .pipe sourcemaps.init()
  .pipe sass(
    indentedSyntax: true
    includePaths: ["node_modules"]
    ).on 'error', sass.logError
  .pipe concatCss('./main.css',
    includePaths: ['node_modules'])
  .pipe sourcemaps.write()
  .pipe gulp.dest 'client/dist'

gulp.task 'sass:watch', ['sass'], ->
  gulp.watch 'client/sass/**/*.sass', ['sass']

gulp.task "build", ['sass'], ->
  b = browserify(
    entries: ['client/app/app.coffee']
    extensions: ['.js', '.coffee', '.html']
    )
  .transform 'coffeeify'
  .transform ngHtml2Js(
    module: 'templates',
    baseDir: 'client/app')
  .bundle()
  .pipe(source('main.js'))
  .pipe gulp.dest('./client/dist')
  
