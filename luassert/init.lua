local _, crequire, brequire = require("newmodule")(...)

local _M = assert( crequire('assert') ) -- require('luassert.assert')

_M._COPYRIGHT   = "Copyright (c) 2012 Olivine Labs, LLC."
_M._DESCRIPTION = "Extends Lua's built-in assertions to provide additional tests and the ability to create your own."
_M._VERSION     = "Luassert 1.4"

-- load basic asserts
local assertions = crequire('assertions') -- require('luassert.assertions')
assertions.register(_M)

local modifiers = crequire('modifiers') -- require('luassert.modifiers')
modifiers.register(_M)

local formatters = crequire('formatters')  -- require('luassert.formatters')
formatters.register(_M)

-- load default language
crequire('languages.en') -- require('luassert.languages.en')

return _M
