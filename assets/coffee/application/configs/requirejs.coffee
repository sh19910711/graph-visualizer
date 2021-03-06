#
#     requirejs_config.js.coffee
#

@requirejs_paths = {
  'application': 'js/application'
  'module01': 'js/module01'
  'module_ixxa': 'js/module_ixxa'
  'module_sune': 'js/module_sune'
  'graph': 'js/graph'
  'parser': 'js/parser'
  'misc': 'js/misc'

  'jquery': 'lib/jquery/js/jquery'
  'bootstrap': 'lib/bootstrap/js/bootstrap'
  'backbone': 'lib/backbone/js/backbone'
  'underscore': 'lib/underscore/js/underscore'
  'd3': 'lib/d3/js/d3'
}

# AMDに対応していないモジュールの依存関係を指定する
@requirejs_shim = {
  'bootstrap': ['jquery']
}

# 設定を適用する
requirejs.config(
  baseUrl: '/'
  paths: @requirejs_paths
  shim: @requirejs_shim
)

