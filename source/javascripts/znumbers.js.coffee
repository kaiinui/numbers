window.onload = ->
  enchant()

  enchant.Sound.enabledInMobileSafari = true

  game = new Core(320, 360)
  game.fps = 30
  game._n = 1
  game._state = "START" # START, PLAYING, CLEAR
  game.preload(['yubi.mp3', 'error.mp3', 'fin.mp3'])

  ButtonLabel = Class.create(Label, {
    initialize: (number)->
      Label.call(this, 60, 60)
      this.x = 8
      this.y = 8
      this.color = "#ffffff"
      this.text = number
      this.font = "32px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
  })

  ButtonSprite = Class.create(Sprite, {
    initialize: ->
      Sprite.call(this, 60, 60)
      this.x = 0
      this.y = 0
      this._framecount = 0
      this.backgroundColor = "#ff5800"
    onenterframe: -> # [REFACTOR] dirty implementation
      if this._framecount >= 1
        this._framecount += 1
        if this._framecount >= 3
          this.backgroundColor = "#ff5800"
          this._framecount = 0
  })

  Button = Class.create(Group, {
    initialize: (n, number)->
      x = (n - 1) % 5
      y = parseInt((n - 1) / 5, 10)

      Group.call(this, 60, 60)
      this.x = x * 64
      this.y = y * 64
      this._n = number
      this._button = new ButtonSprite()
      this.addChild(this._button)
      this.addChild(new ButtonLabel(number))
      game.rootScene.addChild(this)

    ontouchstart: ->
      game._state = "PLAYING"

      if game._n is this._n
        this.remove()
        game.assets['yubi.mp3'].play()
        game._n += 1
      else
        game.assets['error.mp3'].play()
        this._button.backgroundColor = "#cc0000"
        this._button._framecount = 1

      if game._n > 25
        game.assets['fin.mp3'].play()
        game._state = "CLEAR"
  })

  Timer = Class.create(Label, {
    initialize: ->
      Label.call(this, 100, 30)
      this.x = 4
      this.y = 324
      this.text = "0"
      this._t = 0
      this.font = "32px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
      this.color = "#000000"
      game.rootScene.addChild this
    onenterframe: ->
      return unless game._state is "PLAYING"
      this._t += 1
      this.text = (this._t / game.fps).toFixed(2)
  })


  game.onload = ->
    a = []
    for i in [1..25]
      a.push(i)
    shuffled = _.shuffle(a)

    for i in [1..25]
      new Button(i, shuffled[i - 1]) # [REFACTOR]
    new Timer()


  game.start()