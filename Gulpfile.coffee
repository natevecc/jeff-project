gulp = require('gulp')

gulp.task 'default', ->
gulp.task 'coffee', ->
  gulp
    .src('app/**/*.coffee')
    .pipe($.coffee())
    .pipe gulp.dest('.tmp/app')