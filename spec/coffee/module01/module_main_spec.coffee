describe "module01/module_main", ->
  # load tested modules
  beforeEach (done)=>
    requirejs(
      [
        'module01/module_main'
      ]
      (
        Module01
      )=>
        @module = new Module01
        done()
    )

  context "get", =>
    it "#get_one [TODO] remove", ()=>
      expect(@module.get_one()).to.equal 1

    it "#get_two [TODO] remove", ()=>
      expect(@module.get_two()).to.equal 2

    it "#get_three [TODO] remove", ()=>
      expect(@module.get_three()).to.equal 3

