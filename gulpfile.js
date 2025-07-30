const gulp = require("gulp");
const concat = require("gulp-concat");

gulp.task("buildMap", function () {
  return gulp
    .src("Lua/**/*.lua")
    .pipe(concat("war3map.lua"))
    .pipe(gulp.dest("dist"));
});
