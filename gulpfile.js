// npm install --save-dev gulp gulp-postcss gulp-sourcemaps autoprefixer postcss-cssnext postcss-nested postcss-mixins postcss-import csswring rucksack-css css-mqpacker 
// npm install --global gulp-cli
// npm install --g postcss  

// Gulp *
var gulp = require('gulp')
// Uso de PostCSS *
var postcss = require('gulp-postcss')
// Reutilizar estilos de CSS *
var mixins = require('postcss-mixins')
// Importar archivos de CSS dentro de uno solo *
var atImport = require ('postcss-import')
// Extienden la sintaxis de CSS, la posibilidad de anidar clases *
var cssnested = require('postcss-nested')
// Para juntar media queries similares en una sola al final de la página *
var mqpacker = require('css-mqpacker')
// Crear tamaños responsivos para las fuentes *
var rucksack = require('rucksack-css')
// Minificar CSS *
var csswring = require('csswring')
// Utilizar hoy la sintaxis CSS del mañana *
var cssnext = require('postcss-cssnext')



// Tarea para procesar el CSS
gulp.task('css', function () {
	var processors = [
	mixins(),
	atImport(),
	cssnested,
	rucksack(),
	cssnext({browsers:'last 5 versions'}),
	mqpacker,
	//csswring()
	]
	return gulp.src(['./src/css/*.css','./src/css/*.css'])
	.pipe(postcss(processors))
	.pipe(gulp.dest('./tema/assets/css'))
})

// Tarea para procesar archivos
gulp.task('archivos', function() {
	return gulp.src('./src/*.*') 
	.pipe(gulp.dest('./tema'))
});

// Tarea para procesar parciales
gulp.task('parciales', function() {
	return gulp.src('./src/partials/**/*.php') 
	.pipe(gulp.dest('./tema/partials'))
});

// Tarea para procesar JS
gulp.task('js', function() {
	return gulp.src('./src/js/**/*.js') 
	.pipe(gulp.dest('./tema/assets/js'))
});

// Tarea para procesar imágenes
gulp.task('image', function() {
	return gulp.src('./src/img/*.*') 
	.pipe(gulp.dest('./tema/assets/img'))
});

// Tarea para procesar fuentes
gulp.task('fonts', function() {
	return gulp.src('./src/fonts/**/*.*') 
	.pipe(gulp.dest('./tema/assets/fonts'))
});

// Tarea para procesar videos y otros archivos de medios
gulp.task('medios', function() {
	return gulp.src('./src/media/**/*.*') 
	.pipe(gulp.dest('./tema/assets/media'))
});


// Tarea para vigilar los cambios
gulp.task('watch', function () {
	gulp.watch('./src/css/**/*.css', ['css'])
	gulp.watch('./src/**/*.*', ['archivos'])
	gulp.watch('./src/partials/**/*.php', ['parciales'])
	gulp.watch('./src/js/**/*.js', ['js'])
	gulp.watch('./src/img/**', ['image'])
	gulp.watch('./src/fonts/**', ['fonts'])
	gulp.watch('./src/media/**', ['medios'])
})

gulp.task('default', ['css', 'archivos', 'parciales' , 'js', 'image', 'fonts', 'medios', 'watch'])
