import ./types

proc renameHook*(v: LinkSchema, fieldName: var string) {.inline.} =
  if fieldName == "additionalItems":
    fieldName = "additional_items"
  elif fieldName == "additional_items":
    fieldName = "additionalItems"
  elif fieldName == "patternProperties":
    fieldName = "pattern_properties"
  elif fieldName == "pattern_properties":
    fieldName = "patternProperties"
  elif fieldName == "allOf":
    fieldName = "all_of"
  elif fieldName == "all_of":
    fieldName = "allOf"
  elif fieldName == "anyOf":
    fieldName = "any_of"
  elif fieldName == "any_of":
    fieldName = "anyOf"
  elif fieldName == "oneOf":
    fieldName = "one_of"
  elif fieldName == "one_of":
    fieldName = "oneOf"
  elif fieldName == "fragmentResolution":
    fieldName = "fragment_resolution"
  elif fieldName == "fragment_resolution":
    fieldName = "fragmentResolution"
  elif fieldName == "pathStart":
    fieldName = "path_start"
  elif fieldName == "path_start":
    fieldName = "pathStart"

proc renameHook*(v: LinkDescription, fieldName: var string) {.inline.} =
  if fieldName == "mediaType":
    fieldName = "media_type"
  elif fieldName == "media_type":
    fieldName = "mediaType"
  elif fieldName == "encType":
    fieldName = "enc_type"
  elif fieldName == "enc_type":
    fieldName = "encType"
  elif fieldName == "targetSchema":
    fieldName = "target_schema"
  elif fieldName == "target_schema":
    fieldName = "targetSchema"

proc renameHook*(v: LinkSchema2, fieldName: var string) {.inline.} =
  if fieldName == "additionalItems":
    fieldName = "additional_items"
  elif fieldName == "additional_items":
    fieldName = "additionalItems"
  elif fieldName == "patternProperties":
    fieldName = "pattern_properties"
  elif fieldName == "pattern_properties":
    fieldName = "patternProperties"
  elif fieldName == "allOf":
    fieldName = "all_of"
  elif fieldName == "all_of":
    fieldName = "allOf"
  elif fieldName == "anyOf":
    fieldName = "any_of"
  elif fieldName == "any_of":
    fieldName = "anyOf"
  elif fieldName == "oneOf":
    fieldName = "one_of"
  elif fieldName == "one_of":
    fieldName = "oneOf"
  elif fieldName == "fragmentResolution":
    fieldName = "fragment_resolution"
  elif fieldName == "fragment_resolution":
    fieldName = "fragmentResolution"
  elif fieldName == "pathStart":
    fieldName = "path_start"
  elif fieldName == "path_start":
    fieldName = "pathStart"

proc renameHook*(v: LinkDescription2, fieldName: var string) {.inline.} =
  if fieldName == "mediaType":
    fieldName = "media_type"
  elif fieldName == "media_type":
    fieldName = "mediaType"
  elif fieldName == "encType":
    fieldName = "enc_type"
  elif fieldName == "enc_type":
    fieldName = "encType"
  elif fieldName == "targetSchema":
    fieldName = "target_schema"
  elif fieldName == "target_schema":
    fieldName = "targetSchema"

