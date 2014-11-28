module.exports = function coffee(grunt) {

grunt.loadNpmTasks('grunt-contrib-watch');


// snip

return {
  watch: {
      files: ['cloud/*.ls'],
      tasks: ['livescript']
  }
}
}
