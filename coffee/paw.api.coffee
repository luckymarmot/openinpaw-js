((window) ->

    # 
    # Make sure `paw` is a singleton
    # 
    if window.paw
        return

    # 
    # Event Listeners
    # 

    window.addEventListener "keydown", (e) ->
        if e.keyCode == 27
            if _hideOpenInPaw()
                e.preventDefault()
                return false
    # 

    # Private Variables
    # 

    _CSSIsLoaded = false

    # 
    # Private Functions
    # 

    _el = (t, ens, cb, tout) ->
        _called = false
        _cb = (e) ->
            if not _called
                _called = true
                cb(e)
        for en in ens
            t.addEventListener en, _cb
        if tout
            setTimeout _cb, tout

    _loadCSS = (href, onload) ->
        ss = window.document.createElement "link"
        ss.rel = "stylesheet"
        ss.href = href
        ss.media = "all"
        ss.onload = () ->
            setTimeout onload, 100
        document.getElementsByTagName("body")[0].appendChild ss

    _hideOpenInPaw = () ->
        outer = document.getElementById "openinpaw-outer"
        if outer
            oip = outer.getElementsByClassName('openinpaw')[0]
            oip.className = "openinpaw fadeout"
            _el oip, ["animationend", "webkitAnimationEnd"], (() ->
                outer.style.display = "none"
                ), 500
            return true

    _showOpenInPaw = (document_name, pawlink) ->

        _openInPawHTML = (document_name, pawlink) ->
            """
            <div class="openinpaw-middle">
                <div class="openinpaw fadein">
                    <div class="hd">
                        <span class="appicon"></span>
                        Open in <span class="appname">Paw</span>
                    </div>
                    <div class="bd">
                        <span class="dc">Open "#{ document_name }" in Paw – the ultimate HTTP client for Mac.</span>
                        <div class="scc"><span class="sc"></span></div>
                        <div class="btnblk-container">
                            <div class="btnblk">
                                <span>Learn more about Paw</span>
                                <a href="https://luckymarmot.com/paw" class="openinpaw-a-get" target="_blank">Get Paw</a>
                            </div>
                            <div class="btnblk">
                                <span>I already have Paw</span>
                                <a href="#{ pawlink }" class="openinpaw-a-open">Open in Paw</a>
                                <label>
                                    <input name="name" id="id" type="checkbox">
                                    Always open in Paw
                                </span>
                            </div>
                            <div class="clr"></div>
                        </div>
                    </div>
                </div>
            </div>
            """

        _showOuter = () ->
            outer = document.getElementById "openinpaw-outer"
            if not outer
                outer = document.createElement "div"
                outer.id = outer.className = "openinpaw-outer"
                document.getElementsByTagName("body")[0].appendChild outer
            outer.innerHTML = _openInPawHTML(document_name, pawlink)
            outer.getElementsByClassName('openinpaw')[0].className = "openinpaw fadein"
            outer.style.display = ""
            outer.onclick = (e) ->
                if e.target == outer or e.target.parentNode == outer
                    _hideOpenInPaw()

        # CSS is loaded
        if _CSSIsLoaded
            _showOuter()
        # Load CSS
        else
            _CSSIsLoaded = true

            # Load Google Font "Open Sans"
            _loadCSS "http://fonts.googleapis.com/css?family=Open+Sans:400,300"

            # Load "paw.css"
            _loadCSS "http://localluckymarmot.com:8080/stylesheets/paw.css", () ->
                _showOuter()
        
    # 
    # Public Methods
    # 

    _p = {}

    # 
    # Opens in Paw with the given parameters object.
    # @param d The parameters.
    # 
    _p.open = (d) ->
        # `deeplink` is set
        if d.deeplink
            _showOpenInPaw (d.apiname || document.title), d.deeplink

        # `a` DOM object is set
        else if d.a
            _showOpenInPaw (d.apiname || d.a.getAttribute('data-paw-api-name') || document.title), d.a.href

    window.paw = _p
    return
)(window);
