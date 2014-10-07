"use strict"

// -- DEPENDENCIES -------------------------------------------------------------
var gulp    = require('gulp');
var coffee  = require('gulp-coffee');
var concat  = require('gulp-concat');
var header  = require('gulp-header');
var uglify  = require('gulp-uglify');
var gutil   = require('gulp-util');
var pkg     = require('./package.json');

// -- FILES --------------------------------------------------------------------
var path = {
  build : 'assets'};

var source = {
  coffee: [ 'source/entities/*.coffee',
            'source/atoms/*.coffee',
            'source/molecules/*.coffee',
            'source/organisms/*.coffee',
            'source/*.coffee',
            'source/*.*.coffee']};

var dependencies = {
    js:[ 'bower_components/jquery/dist/jquery.min.js']};

var banner = ['/**',
  ' * <%= pkg.name %> - <%= pkg.description %>',
  ' * @version v<%= pkg.version %>',
  ' * @link    <%= pkg.homepage %>',
  ' * @author  <%= pkg.author.name %> (<%= pkg.author.site %>)',
  ' * @license <%= pkg.license %>',
  ' */',
  ''].join('\n');

// -- TASKS --------------------------------------------------------------------

gulp.task('coffee', function() {
  gulp.src(source.coffee)
    .pipe(concat('atoms.' + pkg.name + '.coffee'))
    .pipe(coffee().on('error', gutil.log))
    .pipe(uglify({mangle: false}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.build + '/js'))
});

gulp.task('dependencies', function() {
  gulp.src(dependencies.js)
    .pipe(concat('atoms.' + pkg.name + '.dependencies.js'))
    .pipe(uglify({mangle: false}))
    .pipe(header(banner, {pkg: pkg}))
    .pipe(gulp.dest(path.build + '/js'))
});

gulp.task('default', function() {
  gulp.watch(source.coffee, ['coffee']);
});

gulp.task('init', function() {
  gulp.run(['dependencies', 'coffee'])
});
