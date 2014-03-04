#
#     requirejs_config.js.coffee
#

@requirejs_paths = {
  'app': 'js/app'
  'module01': 'js/module01'
  'module_ixxa': 'js/module_ixxa'
  'module_sune': 'js/module_sune'

  'jquery': 'lib/jquery/js/jquery'
  'bootstrap': 'lib/bootstrap/js/bootstrap'
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
