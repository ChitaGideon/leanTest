module.exports = function coffee(grunt) {

grunt.loadNpmTasks('grunt-livescript');

// snip

return {
    build: {
        expand: true,
        src: ['cloud/*.ls'],
        ext: '.js',
        extDot: 'first'
    }
  }
}
