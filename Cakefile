sass = require 'node-sass'
fs = require 'fs'

task 'build', ->
    task_build_sass()

task 'watch', ->
    watch_file 'paw.sass', '.', () ->
        task_build_sass()

task_build_sass = () ->
    build_sass_file 'paw.sass', 'paw.css'
    build_sass_file 'paw.sass', 'paw.min.css', {outputStyle:'compressed'}

build_sass_file = (inputFile, outputFile, opts = {}) ->
    
    opts.file = inputFile
    opts.sourceMap = false
    opts.includePaths = require('node-bourbon').includePaths
    opts.success = (result) ->
        fs.writeFile outputFile, result.css, (err) ->
            if not err
                console.log "  Written #{ outputFile }"
            else
                console.error "Couldn't write in file"
    opts.error = (error) ->
        console.error "Sass Error: #{ error.message }"

    sass.render opts

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
