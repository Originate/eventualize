gulp = require 'gulp'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
concat = require 'gulp-concat'
header = require 'gulp-header'
gutil = require 'gulp-util'
uglify = require 'gulp-uglify'



gulp.task 'default', ->
  pkg = require '../package.json'
  banner = "/*! #{pkg.name} #{pkg.version},
            copyright #{new Date().getFullYear()} Kevin Goslar,
            see #{pkg.homepage} */\n"
  gulp.src ['./src/eventualize.coffee']
      .pipe coffeelint()
      .pipe coffeelint.reporter()
      .pipe coffee()
      .pipe uglify()
      .pipe concat('eventualize.min.js')
      .pipe header(banner)
      .pipe gulp.dest('lib')
      .on 'error', gutil.log

