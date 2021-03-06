define(
  [
    "backbone"
    "underscore"
    "parser/models/parser_option_model"
    "parser/models/parser_config_model"
  ]
  (
    Backbone
    _
    ParserOptionModel
    ParserConfigModel
  )->
    # パーサーのインタフェース的なクラス
    class ParserBase extends Backbone.Model
      # 初期化
      # @return [ParserBase] void
      initialize: (options)->
        if options
          # ParserConfigModelを取得する
          if options.config
            @config = options.config
          else
            @config = new ParserConfigModel

          # パーサーの種類
          @config.set "type", @constructor.name

          # パーサーの現在の⎋設定を取得
          parser_options = @get_options()

          # 定義済みのオプションをconfigに設定しておく
          option_keys = _(@attributes).keys()
          _(option_keys).each (option_key)=>
            # TODO: optionのキーだけを取り出すメソッドを追加する
            if /^option\//.test option_key
              # option/xxx -> xxx
              option_key = option_key.match(/^option\/(.*)/)[1]
              @config.set_value option_key, @get_option_value option_key

          # オプションの値の変更をconfigに追従させる
          _(option_keys).each (option_key)=>
            if /^option\//.test option_key
              # option/xxx -> xxx
              option_key = option_key.match(/^option\/(.*)/)[1]
              parser_option = @get_option option_key
              parser_option.on "change:value", =>
                @config.set_value option_key, parser_option.get "value"

          # configの内容を反映させる
          @apply_config()

          # fetch()などで変更があるとき
          @config.on "change:options", =>
            @apply_config()

        @

      # configの設定を反映させる
      apply_config: ->
        options = @config.get "options"
        _(options).each (option)=>
          if @get_option(option.key)
            # 配列のときは1つずつ反映させる
            if option.value instanceof Array
              _(option.value).each (value)=>
                @set_option_value option.key, value
            else
              @set_option_value option.key, option.value

      # 与えられた文字列を解析して結果を返す（インターフェース）
      # @param [String] text 解析する文字列
      parse: (text)->
        throw new Error "ERROR_RV7F04: Not Implemented"

      # パーサーの名称を取得する（インターフェース）
      # @return [String] パーサーの名称
      get_name: ->
        throw new Error "ERROR_62Q040: Not Implemented"

      # パーサーのサンプル入力を取得する（インターフェース）
      # @return [String] パーサーのサンプル入力
      get_example_input: ->
        throw new Error "ERROR_W76PM2: Not Implemented"

      # 指定したオプションの値を取得する
      # @param [String] key オプションのID
      # @return [Any] オプションの値
      get_option_value: (key)->
        option = @get_option key
        option.get_value()

      # 指定したオプションの値を設定する
      # @param [String] key オプションのID
      # @return [ParserBase] void
      set_option_value: (key, value)->
        option = @get_option key
        option.set_value value
        # change config
        @config.set_value key, value if @config instanceof ParserConfigModel
        @

      # 指定したオプションを取得する
      # @param [String] key オプションのID
      # @return [ParserOptionModel] 取得されたオプション
      get_option: (key)->
        @get "option/#{key}"

      # すべてのオプションを取得する
      # @return [Array of ParserOptionModel] すべてのオプション
      get_options: ->
        options = []
        keys = _(@attributes).keys()
        _(keys).each (key)=>
          options.push @get key if /^option\//.test key
        options
)

