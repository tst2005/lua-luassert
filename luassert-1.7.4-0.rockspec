package = "luassert"
version = "1.7.4-0"
source = {
  url = "https://github.com/Olivine-Labs/luassert/archive/v1.7.4.tar.gz",
  dir = "luassert-1.7.4"
}
description = {
  summary = "Lua Assertions Extension",
  detailed = [[
    Adds a framework that allows registering new assertions
    without compromising builtin assertion functionality.
  ]],
  homepage = "http://olivinelabs.com/busted/",
  license = "MIT <http://opensource.org/licenses/MIT>"
}
dependencies = {
  "lua >= 5.1",
  "say >= 1.2-1"
}
build = {
  type = "builtin",
  modules = {
    ["luassert.state"] = "luassert/state.lua",
    ["luassert.util"] = "luassert/"util.lua",
    ["luassert.spy"] = "luassert/"spy.lua",
    ["luassert.stub"] = "luassert/"stub.lua",
    ["luassert.assert"] = "luassert/"assert.lua",
    ["luassert.modifiers"] = "luassert/"modifiers.lua",
    ["luassert.assertions"] = "luassert/"assertions.lua",
    ["luassert.mock"] = "luassert/"mock.lua",
    ["luassert.init"] = "luassert/"init.lua",
    ["luassert.formatters.init"] = "luassert/"formatters/init.lua",
    ["luassert.formatters.binarystring"] = "luassert/"formatters/binarystring.lua",
    ["luassert.languages.en"] = "luassert/"languages/en.lua",
    ["luassert.languages.ar"] = "luassert/"languages/ar.lua",
    ["luassert.languages.fr"] = "luassert/"languages/fr.lua",
    ["luassert.languages.nl"] = "luassert/"languages/nl.lua",
    ["luassert.languages.ru"] = "luassert/"languages/ru.lua",
    ["luassert.languages.ua"] = "luassert/"languages/ua.lua",
    ["luassert.languages.zh"] = "luassert/"languages/zh.lua",
    ["luassert.languages.ja"] = "luassert/"languages/ja.lua",
  }
}
