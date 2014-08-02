window.onload = ->
  enchant()

  game = new Core(320, 360)
  game.fps = 30
  game._n = 1

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
      this.backgroundColor = "#002366"
    onenterframe: -> # [REFACTOR] dirty implementation
      if this._framecount >= 1
        this._framecount += 1
        if this._framecount >= 3
          this.backgroundColor = "#002366"
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
      if game._n is this._n
        this.remove()
        game._n += 1
      else
        this._button.backgroundColor = "#cc0000"
        this._button._framecount = 1
  })


  game.onload = ->
    a = []
    for i in [1..25]
      a.push(i)
    shuffled = _.shuffle(a)

    for i in [1..25]
      new Button(i, shuffled[i - 1]) # [REFACTOR]

    timer = new Label(100, 30)
    timer.x = 4
    timer.y = 324
    timer.text = "0"
    timer._t = 0
    timer.color = "#000000"
    timer.addEventListener 'enterframe', ->
      this._t += 1
      this.text = timer._t
    game.rootScene.addChild timer

  game.start()