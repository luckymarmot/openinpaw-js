((window) ->
	# 
	# Google WebFonts
	# 

	WebFontConfig =
		google:
			families:[
				"Open+Sans:400,300:latin"
			]
	(() ->
		wf = document.createElement "script"
		wf.src = "#{ (if "https:" == document.location.protocol then "https" else "http") }://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js"
		wf.type = "text/javascript"
		wf.async = "true"
		s = document.getElementsByTagName("script")[0]
		s.parentNode.insertBefore wf, s
	)();

	# 
	# Load CSS
	# 

	_loadCSS = (href) ->
        "use strict"
        ss = window.document.createElement "link"
        ss.rel = "stylesheet"
        ss.href = href
        ss.media = "all"
        document.getElementsByTagName("body")[0].appendChild ss


	_p = {}

	_openInPawHTML = (document_name, pawlink) ->
		"""
		<div class="openinpaw-middle">
			<div class="openinpaw">
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
							<a href="https://luckymarmot.com/paw" class="openinpaw-a-get">Get Paw</a>
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

	_showOpenInPaw = () ->
		outer = document.getElementById "openinpaw-outer"
		if not outer
			_loadCSS "/stylesheets/paw.css"
			outer = document.createElement "div"
			outer.id = outer.className = "openinpaw-outer"
		outer.innerHTML = _openInPawHTML("My Cute API", "paw://toto")
		document.getElementsByTagName("body")[0].appendChild outer

	# 
	# Opens in Paw with the given parameters object.
	# @param d The parameters.
	# 
	_p.open = (d) ->
		_showOpenInPaw()

	window.paw = _p
	return
)(window);
