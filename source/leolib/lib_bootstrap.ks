// if we have a connection to KSC and have not already copied over our
// dependencies, do so now
for lib in list("lib_fileop", "lib_ui") {
  if not (defined _LOADED_BOOTSTRAP) and addons:rt:hasconnection(ship) {
    copypath("0:/leolib/" + lib, "").
    compile lib. deletepath("1:/" + lib + ".ks").
  }

  runoncepath(lib).
}

// create/get id info for this ship
if has_file("identity.json", 1) {
  set sid to readjson("1:/identity.json").
} else {
  set intMax to 2147483647. // 0x7FFFFFFF (32-bit signed)

  set sid to lexicon(
    "uuid", mod(round(random(), 10) * (10 ^ 10), intMax),
    "guid", 0,
    "name", ship:name
  ).

  writejson(sid, "1:/identity.json").
  writejson(sid, "0:/" + sid["guid"] + "-" + sid["uuid"] + "-identity.json").
}

// important that this is last
set _LOADED_BOOTSTRAP to true.