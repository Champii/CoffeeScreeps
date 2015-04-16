module.exports = (grunt) ->

  grunt.initConfig 
    pkg: grunt.file.readJSON('package.json')
    coffee:
      glob_to_multiple:
        expand: true,
        flatten: true,
        cwd: './',
        src: ['*.coffee'],
        dest: 'js/',
        ext: '.js'
    screeps:
      options:
          email: 'champii.akronym@gmail.com',
          password: 'nDJ&n{nZ'
      dist: 
          src: ['js/*.js']


  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-screeps');

  grunt.registerTask('default', ['coffee', 'screeps']);

