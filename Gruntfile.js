module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    coffeelint: {
      files: ['src/**/*.coffee'],
    },
    watch: {
      files: ['<%= coffeelint.files %>'],
      tasks: ['mochaTest']
    },
    mochaTest: {
      unit: {
        options: {
          reporter: 'spec',
          require: [
            'coffee-script/register',
            function(){ expect=require('chai').expect; },
            function(){ sinon=require('sinon'); }
          ]
        },
        src: ['tests/unit/**/*-spec.coffee']
      },
      acceptance: {
        options: {
          reporter: 'spec',
          require: [
            'coffee-script/register',
            function(){ expect=require('chai').expect; },
            function(){ sinon=require('sinon'); }
          ]
        },
        src: ['tests/acceptance/**/*-spec.coffee']
      }
    },
    coffee: {
      glob_to_multiple: {
        expand: true,
        flatten: false,
        cwd: 'src/',
        src: ['**/*.coffee'],
        dest: 'dist/',
        ext: '.js'
      }
    },
    clean: ["dist"]
  });

  require('load-grunt-tasks')(grunt);

  // test
  grunt.registerTask('test:unit', 'mochaTest:unit');
  grunt.registerTask('test:acceptance', 'mochaTest:acceptance');
  grunt.registerTask('test', ['test:unit', 'test:acceptance']);

  // build
  grunt.registerTask('build', ['clean', 'coffeelint', 'coffee']);

  grunt.registerTask('default', ['test', 'build']);

};
