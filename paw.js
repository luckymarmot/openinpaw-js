(function(window){
	/**
	 * Cookies
	 */
	var cookies = {
	  getItem: function (sKey) {
	    if (!sKey) { return null; }
	    return decodeURIComponent(document.cookie.replace(new RegExp("(?:(?:^|.*;)\\s*" + encodeURIComponent(sKey).replace(/[\-\.\+\*]/g, "\\$&") + "\\s*\\=\\s*([^;]*).*$)|^.*$"), "$1")) || null;
	  },
	  setItem: function (sKey, sValue, vEnd, sPath, sDomain, bSecure) {
	    if (!sKey || /^(?:expires|max\-age|path|domain|secure)$/i.test(sKey)) { return false; }
	    var sExpires = "";
	    if (vEnd) {
	      switch (vEnd.constructor) {
	        case Number:
	          sExpires = vEnd === Infinity ? "; expires=Fri, 31 Dec 9999 23:59:59 GMT" : "; max-age=" + vEnd;
	          break;
	        case String:
	          sExpires = "; expires=" + vEnd;
	          break;
	        case Date:
	          sExpires = "; expires=" + vEnd.toUTCString();
	          break;
	      }
	    }
	    document.cookie = encodeURIComponent(sKey) + "=" + encodeURIComponent(sValue) + sExpires + (sDomain ? "; domain=" + sDomain : "") + (sPath ? "; path=" + sPath : "") + (bSecure ? "; secure" : "");
	    return true;
	  },
	  removeItem: function (sKey, sPath, sDomain) {
	    if (!this.hasItem(sKey)) { return false; }
	    document.cookie = encodeURIComponent(sKey) + "=; expires=Thu, 01 Jan 1970 00:00:00 GMT" + (sDomain ? "; domain=" + sDomain : "") + (sPath ? "; path=" + sPath : "");
	    return true;
	  },
	  hasItem: function (sKey) {
	    if (!sKey) { return false; }
	    return (new RegExp("(?:^|;\\s*)" + encodeURIComponent(sKey).replace(/[\-\.\+\*]/g, "\\$&") + "\\s*\\=")).test(document.cookie);
	  },
	  keys: function () {
	    var aKeys = document.cookie.replace(/((?:^|\s*;)[^\=]+)(?=;|$)|^\s*|\s*(?:\=[^;]*)?(?:\1|$)/g, "").split(/\s*(?:\=[^;]*)?;\s*/);
	    for (var nLen = aKeys.length, nIdx = 0; nIdx < nLen; nIdx++) { aKeys[nIdx] = decodeURIComponent(aKeys[nIdx]); }
	    return aKeys;
	  }
	};

	var _p = {};

	/**
	 * Returns true if client has Paw, false if client doesn't have Paw,
	 * null if no answer is known.
	 */
	var _hasPaw = function() {
		var v = cookies.getItem('pawv');
		return (null === v ? null : (v !== '_'));
	}

	/**
	 * Sets the 'pawv' cookie.
	 */
	var _setHasPaw = function(hasPaw) {
		cookies.setItem('pawv', (hasPaw ? 'paw' : '_'), Infinity, null, null, false);
	}

	/**
	 * Check if user has the desktop Paw app installed, and calls `cb` when
	 * completed.
	 * @param cb A callback function.
	 */
	var _chkHasPaw = function(cb) {
		var r = _hasPaw();
		if (null === r) {
			r = confirm('Do you have Paw?');
			_setHasPaw(r);
		}
		cb(r);
	}

	/**
	 * Opens in Paw with the given parameters object.
	 * @param d The parameters.
	 */
	_p.open = function(d) {
		_chkHasPaw(function(r) {
			if (r) {
				if ('undefined' !== typeof d.deeplink) {
					document.location.href = d.deeplink;
				}
			}
			else {
				document.location.href = 'https://luckymarmot.com/paw';
			}
		});
	}

	window.paw = _p;
})(window);
