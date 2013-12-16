path = require 'path'

module.exports = (grunt) ->

  seleniumPath = path.resolve './node_modules/protractor/selenium'

  grunt.initConfig
    env:
      test:
        PATH: "#{seleniumPath}:process.env.PATH"

    connect:
      server:
        options:
          keepalive: true
          port: 9001
          base: 'app'

    cucumberjs:
      files: 'features/*.feature'

    shell:
      selenium:
        command: './node_modules/protractor/bin/webdriver-manager start'
        options:
          stdout: true

  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-cucumber'
  grunt.loadNpmTasks 'grunt-env'
  grunt.loadNpmTasks 'grunt-shell'

  grunt.registerTask 'server', [
    'connect:server'
  ]

  grunt.registerTask 'selenium', [
    'shell:selenium'
  ]

  grunt.registerTask 'test', [
    'env:test'
    'cucumberjs'
  ]
