--gc:orc
if defined(release) or defined(danger):
    --opt:speed
    --passC:"-flto"
    --passL:"-flto"
