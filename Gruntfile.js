'use strict';


module.exports = function (grunt) {

    // Load the project's grunt tasks from a directory
    require('grunt-config-dir')(grunt, {
        configDir: require('path').resolve('tasks')
    });

    // Register group task
    grunt.registerTask('build', [ 'livescript:build' ]);
    grunt.registerTask('default', [ 'watch']);
};

