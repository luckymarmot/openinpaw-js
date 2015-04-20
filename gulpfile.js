var path = require('path');
var gulp = require('gulp');
var del = require('del');
var compass = require('gulp-compass');
var plumber = require('gulp-plumber');
var coffee = require('gulp-coffee');
var uglify = require('gulp-uglify');
var watch = require('gulp-watch');

gulp.task('default', ['build']);

gulp.task('build', [
  'compass',
  'coffee',
  'static'
]);

gulp.task('clean', function (cb) {
  del([
    './build/'
  ], cb);
});

gulp.task('compass', ['static'], function () {
  return gulp.src('./sass/*.sass')
    .pipe(plumber())
    .pipe(compass({
        config_file: './sass/config.rb',
        require: [],
        project: __dirname,
        http_path: '/',
        relative: true,
        comments: true,
        style: 'compressed',
        css: './build/css/',
        sass: './sass/',
        image: './build/images/'
      }))
    .pipe(gulp.dest('./build/css/'));
});

gulp.task('coffee', function() {
  return gulp.src('./coffee/*.coffee')
    .pipe(plumber())
    .pipe(coffee({
        bare:false
      }))
    .pipe(uglify({
      mangle:true
    }))
    .pipe(gulp.dest('./build/js/'));
});

gulp.task('static', function() {
  return gulp.src('./images/*')
    .pipe(plumber())
    .pipe(gulp.dest('./build/images/'));
});

gulp.task('watch', [], function() {
  gulp.watch(['./coffee/*.coffee', './sass/*.sass'], ['build']);
});
