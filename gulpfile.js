const gulp = require('gulp')
const sass = require('gulp-sass')
const elm = require('gulp-elm')

const paths = {
  styles: {
    src: 'src/styles/**/*.scss',
    dest: 'public'
  },
  elm: {
    src: 'src/elm/**/*.elm',
    out: 'app.js',
    dest: 'public'
  },
  assets: {
    src: 'src/assets/**/*',
    dest: 'public'
  }
}

// Elm
gulp.task('elm:init', elm.init)

gulp.task('elm', ['elm:init'], () =>
  gulp.src(paths.elm.src)
    .pipe(elm.bundle(paths.elm.out))
    .on('error', () => {})
    .pipe(gulp.dest(paths.elm.dest))
)

gulp.task('watch:elm', ['elm'], () =>
  gulp.watch(paths.elm.src, ['elm'])
)

// Styles
gulp.task('styles', () =>
  gulp.src(paths.styles.src)
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest(paths.styles.dest))
)

gulp.task('watch:styles', ['styles'], () =>
  gulp.watch(paths.styles.src, ['styles'])
)

// Assets
gulp.task('assets', () =>
  gulp.src(paths.assets.src)
    .pipe(gulp.dest(paths.assets.dest))
)

gulp.task('watch:assets', ['assets'], () =>
  gulp.watch(paths.assets.src, ['assets'])
)

// Default tasks
gulp.task('build', ['elm', 'styles', 'assets'])
gulp.task('watch', ['watch:elm', 'watch:styles', 'watch:assets'])
gulp.task('dev', ['watch'])
gulp.task('default', ['build'])
