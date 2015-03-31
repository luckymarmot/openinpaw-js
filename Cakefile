sass = require 'node-sass'
fs = require 'fs'

task 'build', ->
    task_build_sass()

task 'watch', ->
    watch_file 'paw.sass', '.', () ->
        task_build_sass()

task_build_sass = () ->
    inputFile = 'paw.sass'
    outputFile = 'paw.min.css'

    sass.render
        file: inputFile
        outputStyle: 'compressed'
        sourceMap: false
        success: (result) ->
            fs.writeFile outputFile, result.css, (err) ->
                if not err
                    console.log "  Written #{ outputFile }"
                else
                    console.error "Couldn't write in file"
        error: () ->
            console.error "Sass Error..."

watch_file = (filename, dir, fn) ->
    filepath = "#{dir}/#{filename}"
    try
        fs.watchFile filepath, persistent:true, interval:500, (event, _filename) ->
            fn filename
            return true
        console.log "Watching #{filename}"
    catch e
        console.log "Error watching #{filename}"
        console.log e

watch_files = (files, dir, fn) ->
    for filename in files
        watch_file filename, dir, fn
