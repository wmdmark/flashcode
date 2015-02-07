# See docs at https://github.com/brunch/brunch/blob/stable/docs/config.md
exports.config =
  conventions:
    assets: /^app\/assets\//
  paths:
    public: 'public'
    watched: ['app', 'vendor', 'test']  
  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /^(bower_components|vendor)/
        'test/js/test.js': /^test[\\/](?!vendor)/
        'test/js/test-vendor.js': /^test[\\/](?=vendor)/
      order:
        before: [
          'vendor/scripts/underscore-min.js'
          'vendor/scripts/chai.js'
          'vendor/scripts/jquery-2.1.0.min.js'
          'vendor/scripts/jquery-ui.js'
          'vendor/scripts/bootstrap.js'
          'vendor/scripts/backbone-min.js'
          'vendor/scripts/backbone.marionette.min.js'
          'vendor/scripts/rivets.min.js'
        ]
    stylesheets:
      joinTo:
        'css/app.css':  /^app/
        'css/vendor.css': /^(vendor|bower_components)/
        'test/css/test.css': /^test[\\/](?!vendor)/
        'test/css/vendor.css': /^test[\\/](?=vendor)/
    templates:
      joinTo: 'js/app.js'
  plugins:
    sass:
      mode: 'ruby'
      options: ["--compass"]
  modules:
    nameCleaner: (path) ->
      cleanPath = path.replace(/^/, '')
      cleanPath.replace(/^app\//, '')
  overrides:
    prod:
      optimize: false
      sourceMaps: false
      plugins: autoReload: enabled: false
